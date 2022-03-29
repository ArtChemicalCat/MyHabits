//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Николай Казанин on 28.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
//MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
//MARK: - Layout
    private func layout() {
        view.addSubview(tableView)
        navigationItem.title = "Информация"
        tableView.separatorStyle = .none
        tableView.fillParentView()
//        navigationController?.navigationBar.backgroundColor = UIColor(red: 255/249, green: 255/249, blue: 255/249, alpha: 0.94)
    }
}

//MARK: - UITableViewDelegate
extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "Привычка за 21 день"
            title.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
            
            return title
        }()
        let header: UIView = {
            let header = UIView()
            header.addSubview(title)
            
            return header
        }()
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: header.topAnchor, constant: 22),
            title.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),
        ])
        
        return header
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
//MARK: - UITableViewDataSource
extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constant.habitSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.id, for: indexPath) as! InfoTableViewCell
        cell.label.text = Constant.habitSteps[indexPath.row]
        
        return cell
    }
    
    
}
