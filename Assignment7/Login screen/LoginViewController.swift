//
//  LoginViewController.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginScreenView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes App"
        
        self.view.backgroundColor = .white
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func loginButtonTapped() {
        if let emailText = loginView.emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let passwordText = loginView.passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            if !isValidEmail(emailText) {
                showAlert(title: "Invalid Email!", message: "Please enter a valid email address.")
                return
            }
            
            if passwordText.isEmpty {
                showAlert(title: "Password cannot be empty!", message: "Please enter password.")
                return
            }
            
            setLoading(true)
            
            Task {
                do {
                    let token = try await AllAPIs.shared.login(email: emailText, password: passwordText)
                    print("Received token: \(token)")
                    TokenManager.shared.token = token
                    
                    await MainActor.run {
                        setLoading(false)
                        print("logged in")
                        notificationCenter.post(name: .loggedIn, object: nil)
                    }
                } catch AuthError.custom(let errorMessage) {
                    await MainActor.run {
                        setLoading(false)
                        showAlert(title: "Login Failed", message: errorMessage)
                    }
                } catch {
                    print("Login error: \(error)")
                    await MainActor.run {
                        setLoading(false)
                        showAlert(title: "Login Failed",
                                message: "An unexpected error occurred. Please try again.")
                    }
                }
            }
        }
    }
    
    
    @objc func registerButtonTapped() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
        
    func setLoading(_ loading: Bool) {
        loginView.loginButton.isEnabled = !loading
        if loading {
            loginView.activityIndicator.startAnimating()
            loginView.loginButton.setTitle("", for: .normal)
        } else {
            loginView.activityIndicator.stopAnimating()
            loginView.loginButton.setTitle("Login", for: .normal)
        }
    }
        
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

