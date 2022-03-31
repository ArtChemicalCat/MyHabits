//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Николай Казанин on 29.03.2022.
//

import UIKit

class HabitViewController: UIViewController {
    var habitName: String?
//MARK: - Views
    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        
        return label
    }()
    
    lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = nil
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.delegate = self
        textField.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        return textField
    }()
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        
        return label
    }()
        
    lazy var colorButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle.fill")
        view.tintColor = UIColor(named: "orange")
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(chooseColor))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        
        picker.addTarget(self, action: #selector(setTime(_:)), for: .valueChanged)
        return picker
    }()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Создать"
        setTime(timePicker)
        configureController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
 
//MARK: - Layout
    
    /// Настраивает контроллер
    func configureController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveNewHabit))
        
        [habitNameLabel, habitNameTextField, colorLabel, colorButton, timeLabel, timePicker]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview($0)
            }
        
        NSLayoutConstraint.activate([
            habitNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            habitNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            
            habitNameTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 7),
            habitNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 40),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
//MARK: - Actions
    
    /// Конвертирует дату во время в формат HH:mm, и устанавливает текст лейбла timeLabel
    /// - Parameter date: конвертируемая дата
    @objc private func setTime(_ picker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        timeLabel.text = "Каждый день в \(formatter.string(from: picker.date))"
    }
    
    @objc private func saveNewHabit() {
        if let name = habitName {
            let newHabit = Habit(name: name,
                                 date: timePicker.date,
                                 color: colorButton.tintColor ?? .black)
            HabitsStore.shared.habits.append(newHabit)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func chooseColor() {
        let colorPickerController = UIColorPickerViewController()
        colorPickerController.selectedColor = colorButton.tintColor!
        colorPickerController.delegate = self
        navigationController?.pushViewController(colorPickerController, animated: true)
    }

    @objc private func nameTextChanged() {
        habitName = habitNameTextField.text
    }
}

//MARK: - UITextFieldDelegate
extension HabitViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.habitNameTextField.endEditing(true)
        return true
    }
}

//MARK: - UIColorPickerViewControllerDelegate
extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorButton.tintColor = color
    }
    
}
