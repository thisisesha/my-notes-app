//
//  Note.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import Foundation

struct Note: Codable {
    var _id: String
    var userId: String
    var text: String
    
    init(_id: String, userId: String, text: String) {
        self._id = _id
        self.userId = userId
        self.text = text
    }
}
