//
//  AuthResponse.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import Foundation

struct AuthResponse: Codable {
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "x-access-token"
    }
    
    init(token: String) {
        self.token = token
    }
}
