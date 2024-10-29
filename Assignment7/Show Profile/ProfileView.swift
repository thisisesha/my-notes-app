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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = .white
        
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
    
    func setUpNameLabel(){
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
      //  stackView.addSubview(nameLabel)
    }
    
    func setUpEmailLabel(){
        emailLabel = UILabel()
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
      //  stackView.addSubview(emailLabel)
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
        self.addSubview(stackView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

}
