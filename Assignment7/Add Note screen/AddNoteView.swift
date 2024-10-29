//
//  AddNoteView.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class AddNoteView: UIView {

    var textView: UITextView!
    var placeholderLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = .white
        
        setupTextView()
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextView() {
        textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        
        // Create the placeholder label
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter your note here..."
        placeholderLabel.textColor = .lightGray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textView)
        self.addSubview(placeholderLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 300),
            
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5)
        ])
        
        updatePlaceholderVisibility()
    }
    
    func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

}

extension AddNoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
}
