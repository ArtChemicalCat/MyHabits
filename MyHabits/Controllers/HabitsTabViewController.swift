//
//  HabitsTabViewController.swift
//  MyHabits
//
//  Created by Николай Казанин on 28.03.2022.
//

import UIKit

class HabitsTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        let habitsTab = UINavigationController(rootViewController: HabitsViewController())
        let infoTab = UINavigationController(rootViewController: InfoViewController())
        habitsTab.tabBarItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        habitsTab.tabBarItem.title = "Информация"
        infoTab.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        infoTab.tabBarItem.title = "Привычки"
        view.layer.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1).cgColor
        tabBar.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 0.8)
        setViewControllers([habitsTab, infoTab], animated: true)
    }
}
