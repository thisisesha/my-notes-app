//
//  User.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import Foundation

struct User: Codable {
    var _id: String
    var name: String
    var email: String
    
    init(_id: String, name: String, email: String) {
        self._id = _id
        self.name = name
        self.email = email
    }
}
