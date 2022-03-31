//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Николай Казанин on 30.03.2022.
//

import UIKit

class HabitDetailsViewController: UITableViewController {
    let habit: Habit
    
    private lazy var calendar = Calendar.current
    
    init(_ habit: Habit) {
        self.habit = habit
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseID")
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Вчера"
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: Date.now.advanced(by: -86400 * 1)) ? .checkmark : .none
        case 1:
            cell.textLabel?.text = "Позавчера"
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: Date.now.advanced(by: -86400 * 2)) ? .checkmark : .none
        case 2:
            cell.textLabel?.text = formatter.string(from: Date.now.advanced(by: -86400 * 3))
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: Date.now.advanced(by: -86400 * 3)) ? .checkmark : .none
        case 3:
            cell.textLabel?.text = formatter.string(from: Date.now.advanced(by: -86400 * 4))
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: Date.now.advanced(by: -86400 * 4)) ? .checkmark : .none
        default:
            break
        }
        return cell
    }
    
    private func configureNavigationBar() {
        let rightButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(edit))
        navigationItem.title = habit.name
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func edit() {
        let vc = EditHabitViewController()
        vc.colorButton.tintColor = habit.color
        vc.habitNameTextField.text = habit.name
        vc.timePicker.date = habit.date
        vc.habit = habit
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}





