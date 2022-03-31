//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by Николай Казанин on 30.03.2022.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {
    var isTaken = false {
        didSet {
            checkmark.image = isTaken ? UIImage(systemName: "checkmark") : UIImage()
        }
    }
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let checkmark = UIImageView()
    
    
    private func configureCell() {
        [dateLabel, checkmark].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
        
        ])
    }
}
