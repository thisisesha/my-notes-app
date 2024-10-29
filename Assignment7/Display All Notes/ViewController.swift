//
//  ViewController.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    let notesView = NotesView()
    var notes = [Note]()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = notesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes App"
        
        self.view.backgroundColor = .white
        
        if TokenManager.shared.token == nil {
            print("calling logging screen")
            showLoginScreen()
        } else {
            // Load notes
            loadNotes()
        }
        
        let profileIcon = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(profileIconTapped))
        navigationItem.leftBarButtonItem = profileIcon
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        notesView.tableViewNote.dataSource = self
        notesView.tableViewNote.delegate = self
        notesView.tableViewNote.register(NotesTableViewCell.self, forCellReuseIdentifier: "notes")
        
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForUserLoggedIn(notification:)),
                    name: .loggedIn,
                    object: nil)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForUserRegistered(notification:)),
                    name: .registered,
                    object: nil)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForNoteAdded(notification:)),
                    name: .noteAdded,
                    object: nil)
        
    }
    
    @objc func onAddBarButtonTapped() {
        let addNoteVC = AddNoteController()
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
    
    @objc func profileIconTapped() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .pageSheet
        present(profileVC, animated: true)
    }
    
    @objc func notificationReceivedForNoteAdded(notification: Notification){
        if let userInfo = notification.userInfo, let newNote = userInfo["note"] as? Note {
            notes.append(newNote)
            notesView.tableViewNote.reloadData()
        }
    }
    
    @objc func notificationReceivedForUserLoggedIn(notification: Notification){
        dismiss(animated: true) { [weak self] in
            // Fetch notes after successful login
            self?.loadNotes()
        }
    }
    
    @objc func notificationReceivedForUserRegistered(notification: Notification){
        dismiss(animated: true) { [weak self] in
            // Fetch notes after successful registration
            self?.loadNotes()
        }
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    func showLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    func loadNotes() {
        print("called load notes")
        Task {
            do {
                if let token = TokenManager.shared.token {
                    let fetchedNotes = try await AllAPIs.shared.getAllNotes(token: token)
                    await MainActor.run {
                        self.notes = fetchedNotes
                        self.notesView.tableViewNote.reloadData()
                    }
                } else {
                    showAlert(title: "Error", message: "Could not fetch token")
                }
            } catch {
                print("Error fetching notes: \(error)")
                await MainActor.run {
                    showAlert(title: "Error", message: "Failed to fetch notes")
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func deleteSelected(noteId: String, at indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Delete",
            message: "Are you sure you want to delete this contact?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            if let self = self {
                Task {
                // Call deleteNote to handle the deletion
                    do {
                        try await self.deleteNoteById(noteId, at: indexPath)
                    } catch {
                        self.showAlert(title: "Error", message: "Failed to delete note: \(error.localizedDescription)")
                    }
                }
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }

    
    func deleteNoteById(_ noteId: String, at indexPath: IndexPath) async throws {
        if let token = TokenManager.shared.token {
            
            do {
                try await AllAPIs.shared.deleteNote(id: noteId, token: token)
                
                await MainActor.run {
                    self.notes.remove(at: indexPath.row)
                    self.notesView.tableViewNote.deleteRows(at: [indexPath], with: .automatic)
                    print("Note deleted")
                }
            } catch {
                throw error // propagate the error to be caught in deleteSelected
            }
        } else {
            showAlert(title: "Error", message: "Could not retrieve token.")
            return
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableViewCell
        
        let note = notes[indexPath.row]
        cell.labelDesc.text = note.text
        
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        buttonOptions.setImage(
            UIImage(systemName: "trash"), for: .normal)
            buttonOptions.addAction(
                UIAction(
                    title: "Delete",
                    handler: { [weak self] _ in
                        self?.deleteSelected(noteId: note._id, at: indexPath)
                    }), for: .touchUpInside)
        cell.accessoryView = buttonOptions
        
        return cell
    }
    
}


