//
//  ProfileViewController.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Profile"
        
        self.view.backgroundColor = .white
        
        fetchUserDetails()
        
        profileView.closeButton.addTarget(self, action: #selector(onCloseButtonTapped), for: .touchUpInside)
        profileView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func onCloseButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func logoutTapped() {
        TokenManager.shared.token = nil
        
        if let presentingVC = presentingViewController as? UINavigationController,
            let mainVC = presentingVC.viewControllers.first as? ViewController {
                dismiss(animated: true) {
                mainVC.showLoginScreen()
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    func fetchUserDetails() {
        Task {
            do {
                if let token = TokenManager.shared.token {
                    let user = try await AllAPIs.shared.getUserDetails(token: token)
                    await MainActor.run {
                        profileView.nameLabel.text = "Name: \(user.name)"
                        profileView.emailLabel.text = "Email: \(user.email)"
                    }
                }
            } catch {
                print("Error fetching user details: \(error)")
                showAlert(title: "Error", message: "Failed to fetch user details")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
