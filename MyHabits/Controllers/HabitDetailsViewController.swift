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
        HabitsStore.shared.dates.count - 1
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
        let dateIndex = HabitsStore.shared.dates.endIndex - 2 - indexPath.row
        let date = HabitsStore.shared.dates[dateIndex]
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Вчера"
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: date) ? .checkmark : .none
        case 1:
            cell.textLabel?.text = "Позавчера"
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: date) ? .checkmark : .none
        default:
            cell.textLabel?.text = formatter.string(from: date)
            cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: date) ? .checkmark : .none
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





