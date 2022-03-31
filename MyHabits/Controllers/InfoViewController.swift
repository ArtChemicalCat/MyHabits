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
        tableView.showsVerticalScrollIndicator = false
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
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate
extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "Привычка за 21 день"
            title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            
            return title
        }()
        let header: UIView = {
            let header = UIView()
            header.addSubview(title)
            
            return header
        }()
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: header.topAnchor, constant: 22),
            title.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: header.bottomAnchor),
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
