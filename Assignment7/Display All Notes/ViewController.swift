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
    
    override func loadView() {
        view = notesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes App"
        
        self.view.backgroundColor = .white
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        notesView.tableViewNote.dataSource = self
        notesView.tableViewNote.delegate = self
        notesView.tableViewNote.register(NotesTableViewCell.self, forCellReuseIdentifier: "notes")
        
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
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
