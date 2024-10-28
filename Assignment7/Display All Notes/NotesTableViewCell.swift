//
//  NotesTableViewCell.swift
//  Assignment7
//
//  Created by Esha Chiplunkar on 10/28/24.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    var labelDesc: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabelDesc()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupLabelDesc(){
        labelDesc = UILabel()
        labelDesc.lineBreakMode = .byTruncatingTail
        labelDesc.numberOfLines = 1
        labelDesc.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDesc)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
                
            labelDesc.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelDesc.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            labelDesc.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            labelDesc.heightAnchor.constraint(equalToConstant: 20),
            labelDesc.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),
                
        ])
    }

}
