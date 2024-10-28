//
//  NotesView.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class NotesView: UIView {

    var tableViewNote: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        backgroundColor = .white
                
        setupTableViewNote()
        initConstraints()
            
    }
        
    func setupTableViewNote(){
        tableViewNote = UITableView()
        tableViewNote.register(NotesTableViewCell.self, forCellReuseIdentifier: "notes")
        tableViewNote.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewNote)
    }
        
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewNote.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewNote.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewNote.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewNote.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
