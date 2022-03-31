//
//  ProgressCollectionViewCellTableViewCell.swift
//  MyHabits
//
//  Created by Николай Казанин on 30.03.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var progress = HabitsStore.shared.todayProgress {
        didSet {
            progressLabel.text = "\(Int(progress * 100))%"
            progressBarTrailingConstraint.constant = -(contentView.bounds.width - 24) * CGFloat(1-progress)
            self.layoutIfNeeded()
        }
    }
    
    private var progressBarTrailingConstraint = NSLayoutConstraint()
    
//MARK: - Views
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
//        label.text = "\(Int(progress * 100))%"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    private let emptyProgressBar: UIView = {
        let bar = UIView()
        bar.layer.cornerRadius = 3.5
        bar.backgroundColor = .systemGray
        
        return bar
    }()
    
    private let completedProgressBar: UIView = {
        let bar = UIView()
        bar.layer.cornerRadius = 3.5
        bar.backgroundColor = UIColor(named: "purple")
        
        return bar
    }()
    
//MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//MARK: - Layout
    private func configureCell() {
        [label, progressLabel, emptyProgressBar, completedProgressBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        contentView.layer.cornerRadius = 8
        backgroundColor = .clear
        contentView.backgroundColor = .white
        progressBarTrailingConstraint = completedProgressBar.trailingAnchor.constraint(equalTo: emptyProgressBar.trailingAnchor,
                                                                                       constant: -(contentView.bounds.width - 24) * CGFloat(1-progress))
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            progressLabel.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            emptyProgressBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            emptyProgressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            emptyProgressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            emptyProgressBar.heightAnchor.constraint(equalToConstant: 7),
            
            completedProgressBar.leadingAnchor.constraint(equalTo: emptyProgressBar.leadingAnchor),
            completedProgressBar.topAnchor.constraint(equalTo: emptyProgressBar.topAnchor),
            completedProgressBar.bottomAnchor.constraint(equalTo: emptyProgressBar.bottomAnchor),
            progressBarTrailingConstraint,
            
            contentView.bottomAnchor.constraint(equalTo: emptyProgressBar.bottomAnchor, constant: 15)
            
        ])
        
    }
}
