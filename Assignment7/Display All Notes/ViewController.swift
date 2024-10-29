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
        
    }
    
    @objc func profileIconTapped() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .pageSheet
        present(profileVC, animated: true)
    }
    
    @objc func notificationReceivedForUserLoggedIn(notification: Notification){
        dismiss(animated: true) { [weak self] in
            // Fetch notes after successful login
            self?.loadNotes()
        }
    }
    
    @objc func notificationReceivedForUserRegistered(notification: Notification){
        dismiss(animated: true) { [weak self] in
            // Fetch notes after successful login
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
            // Add your notes loading logic here
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
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        getContactDetails(name: self.contactNames[indexPath.row])
//        detailsController.contactName = contactNames[indexPath.row]
//        navigationController?.pushViewController(detailsController, animated: true)
//    }
}


