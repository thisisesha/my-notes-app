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
    var __v: Int
    
    init(_id: String, userId: String, text: String, __v: Int) {
        self._id = _id
        self.userId = userId
        self.text = text
        self.__v = __v
    }
}
