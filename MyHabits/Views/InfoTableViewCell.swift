//
//  InfoTableViewCell.swift
//  MyHabits
//
//  Created by Николай Казанин on 28.03.2022.
//

import UIKit

final class InfoTableViewCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: label.topAnchor, constant: -6),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -16)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
