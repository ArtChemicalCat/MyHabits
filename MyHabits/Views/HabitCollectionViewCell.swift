//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Николай Казанин on 30.03.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
        
    var habit: Habit? {
        didSet {
            nameLabel.text = habit?.name
            nameLabel.textColor = habit?.color
            checkmarkView.image = (habit?.isAlreadyTakenToday ?? false) ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
            checkmarkView.tintColor = habit?.color
            counterLabel.text = "Счетчик: \(habit?.trackDates.count ?? 0)"
            timeLabel.text = habit?.dateString
        }
    }
    
//MARK: - Views
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        
        return label
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var checkmarkView: UIImageView = {
        let view = UIImageView()
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(checkHabit))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        return view
    }()
//MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layout
    private func configureCell() {
        [nameLabel, timeLabel, counterLabel, checkmarkView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            counterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            checkmarkView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            checkmarkView.widthAnchor.constraint(equalToConstant: 38),
            checkmarkView.heightAnchor.constraint(equalToConstant: 38),
            contentView.bottomAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20)
        ])
    }
    
//MARK: - Actions
    @objc private func checkHabit() {
        guard let habit = habit, !habit.isAlreadyTakenToday else { return }
        HabitsStore.shared.track(habit)
        checkmarkView.image = habit.isAlreadyTakenToday ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        counterLabel.text = "Счетчик: \(habit.trackDates.count)"
    }
    
}
