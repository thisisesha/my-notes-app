//
//  AuthResponse.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import Foundation

struct AuthResponse: Codable {
    var auth: Bool
    var token: String
    
    init(auth: Bool, token: String) {
        self.auth = auth
        self.token = token
    }
}
