//
//  EditHabitViewController.swift
//  MyHabits
//
//  Created by Николай Казанин on 30.03.2022.
//

import UIKit

class EditHabitViewController: HabitViewController {
    
    var habit: Habit? {
        didSet {
            habitName = habit?.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    override func configureController() {
        super.configureController()
        let button = UIButton(type: .system)
        button.tintColor = UIColor(red: 1, green: 0.231, blue: 0.188, alpha: 1)
        button.setTitle("Удалить привычку", for: .normal)
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            button.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureNavigationBar() {
        let leftButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismissChanges))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem?.action = #selector(self.updateHabit)
    }
    
    @objc private func dismissChanges() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func updateHabit() {
        guard let name = habitName,
              name.count > 0 else { return }
        habit?.name = name
        habit?.date = timePicker.date
        habit?.color = colorButton.tintColor!
        HabitsStore.shared.save()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func deleteHabit() {
        let alert = UIAlertController(title: "Удалить привычку",
                                      message: "Вы хотите удалить привычку \(habit!.name)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [unowned self] _ in
            HabitsStore.shared.habits.removeAll(where: { $0 == self.habit })
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
