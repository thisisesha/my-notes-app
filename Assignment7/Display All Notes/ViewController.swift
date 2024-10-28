//
//  ViewController.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    let notesView = NotesView()
    
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
        
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    

}

