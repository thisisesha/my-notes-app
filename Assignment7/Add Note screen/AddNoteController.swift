//
//  AddNoteController.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class AddNoteController: UIViewController {
    
    let addNoteView = AddNoteView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = addNoteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Note"
        
        self.view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveBarButtonTapped)
        )
    }
    

    @objc func onSaveBarButtonTapped(){
        
        if let text = addNoteView.textView.text{
            if text.isEmpty {
                showAlert(title: "Text cannot be empty!", message: "Please enter note description.")
            }
            
            if let token = TokenManager.shared.token {
                Task {
                    do {
                    // Call the addNote API
                        let newNote = try await AllAPIs.shared.addNote(text: text, token: token)
                        
                        await MainActor.run{
                            print("Note saved: \(newNote)")
                            NotificationCenter.default.post(name: .noteAdded, object: nil, userInfo: ["note": newNote])
                            navigationController?.popViewController(animated: true)
                        }
                    } catch {
                        showAlert(title: "Error", message: "Failed to save added note: \(error.localizedDescription)")
                    }
                }
            } else {
                showAlert(title: "Error", message: "Could not retrieve token.")
            }
                    
            } else{
                print("Unable to fetch text")
            }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
