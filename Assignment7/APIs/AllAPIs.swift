//
//  AllAPIs.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/25/24.
//

import Foundation
import Alamofire

class AllAPIs{
    
    static let shared = AllAPIs()
    private let authBaseURL = "http://apis.sakibnm.work:3000/api/auth"
    private let notesBaseURL = "http://apis.sakibnm.work:3000/api/note"
    
    func register(name: String, email: String, password: String) async throws -> String {
        let parameters: [String: String] = [
            "name": name,
            "email": email,
            "password": password
        ]
            
        let url = "\(authBaseURL)/register"
            
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .post, parameters: parameters)
                .responseData { response in
                    if let data = response.data,
                       let json = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(json)")
                    }
                }
                .responseDecodable(of: AuthResponse.self) { response in
                    switch response.result {
                        case .success(let authResponse):
                            continuation.resume(returning: authResponse.token)
                        case .failure(let error):
                            print("Failed with error: \(error)")
                            continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func login(email: String, password: String) async throws -> String {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
            
        let url = "\(authBaseURL)/login"
            
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .post, parameters: parameters)
                .responseData { response in  
                    if let data = response.data,
                       let json = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(json)")
                    }
                }
                .responseDecodable(of: AuthResponse.self) { response in
                    switch response.result {
                        case .success(let authResponse):
                            continuation.resume(returning: authResponse.token)
                        case .failure(let error):
                            print("Failed with error: \(error)")
                            continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getUserDetails(token: String) async throws -> User {
        let url = "\(authBaseURL)/me"
        let headers: HTTPHeaders = ["x-access-token": token]
            
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: User.self) { response in
                switch response.result {
                    case .success(let user):
                        continuation.resume(returning: user)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getAllNotes(token: String) async throws -> [Note] {
        let url = "\(notesBaseURL)/getall"
            
        return try await withCheckedThrowingContinuation { continuation in
            let headers: HTTPHeaders = ["x-access-token": token]
            
            AF.request(url, method: .get, headers: headers)
                .responseDecodable(of: NotesResponse.self) { response in
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                
                switch response.result {
                    case .success(let notesResponse):
                    continuation.resume(returning: notesResponse.notes)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func addNote(text: String, token: String) async throws -> Note {
        let url = "\(notesBaseURL)/post"
        let headers: HTTPHeaders = ["x-access-token": token]
        let parameters: [String: String] = ["text": text]
            
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: Note.self) { response in
                if let data = response.data,
                   let json = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(json)")
                }
                switch response.result {
                    case .success(let note):
                        continuation.resume(returning: note)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func deleteNote(id: String, token: String) async throws {
        let url = "\(notesBaseURL)/delete"
        let headers: HTTPHeaders = ["x-access-token": token]
        let parameters: [String: String] = ["id": id]
            
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .post, parameters: parameters, headers: headers)
            .response { response in
                if let data = response.data,
                   let json = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(json)")
                }
                if let error = response.error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
