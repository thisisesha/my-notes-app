//
//  LoginScreenView.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/26/24.
//

import UIKit

class LoginScreenView: UIView {

    var scrollView: UIScrollView!
    var contentWrapper: UIView!
    var titleLabel: UILabel!
    var emailText: UITextField!
    var passwordText: UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = .white
        
        setupScrollView()
        setupContentWrapper()
        setUpTitleLabel()
        setUpEmailTextField()
        setUpPasswordTextField()
        setUpLoginButton()
        setUpRegisterButton()
        setUpActivityIndicator()
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView(){
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentWrapper(){
        contentWrapper = UIView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentWrapper)
    }
    
    func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Login"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(titleLabel)
    }
    
    func setUpEmailTextField() {
        emailText = UITextField()
        emailText.placeholder = "Email"
        emailText.borderStyle = .roundedRect
        emailText.autocapitalizationType = .none
        emailText.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(emailText)
    }
    
    func setUpPasswordTextField() {
        passwordText = UITextField()
        passwordText.placeholder = "Password"
        passwordText.borderStyle = .roundedRect
        passwordText.autocapitalizationType = .none
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(passwordText)
    }
    
    func setUpLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginButton)
    }
    
    func setUpRegisterButton(){
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Don't have an account? Register!", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(registerButton)
    }
    
    func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(activityIndicator)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            contentWrapper.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            emailText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailText.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -20),
            emailText.heightAnchor.constraint(equalToConstant: 44),
            
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 16),
            passwordText.leadingAnchor.constraint(equalTo: emailText.leadingAnchor),
            passwordText.trailingAnchor.constraint(equalTo: emailText.trailingAnchor),
            passwordText.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: emailText.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailText.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            registerButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
            
        ])
    }

}
