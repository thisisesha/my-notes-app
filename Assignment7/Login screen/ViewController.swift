//
//  ViewController.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    let loginView = LoginScreenView()
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes App"
        
        self.view.backgroundColor = .white
    }


}

