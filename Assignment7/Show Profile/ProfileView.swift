//
//  ProfileView.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class ProfileView: UIView {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var logoutButton: UIButton!
    var closeButton: UIButton!
    var stackView: UIStackView!
    var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        setUpContainerView()
        setUpNameLabel()
        setUpEmailLabel()
        setUpLogoutButton()
        setUpCloseButton()
        setupStackView()
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContainerView() {
        containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
    }
    
    func setUpNameLabel(){
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .darkGray
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpEmailLabel(){
        emailLabel = UILabel()
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textColor = .gray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpLogoutButton(){
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.layer.cornerRadius = 8
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpCloseButton() {
        closeButton = UIButton(type: .system)
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeButton)
    }
    
    func setupStackView(){
        stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel, logoutButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalToConstant: 200),
                        
            // Stack view constraints
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                        
            logoutButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
                        
            // Close button constraints
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

}
