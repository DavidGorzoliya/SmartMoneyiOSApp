//
//  MainTabBarController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit
import RealmSwift

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func configureViewControllers() {
        let balanceViewController = UINavigationController(rootViewController: BalanceViewController())
        balanceViewController.tabBarItem = UITabBarItem(title: "Balance", image: UIImage(systemName: "dollarsign.circle"), tag: 0)
        let objectiveViewController = UINavigationController(rootViewController: ObjectiveViewController())
        objectiveViewController.tabBarItem = UITabBarItem(title: "Objective", image: UIImage(systemName: "scope"), tag: 1)
        let moneyBoxViewController = UINavigationController(rootViewController: MoneyBoxViewController())
        moneyBoxViewController.tabBarItem = UITabBarItem(title: "MoneyBox", image: UIImage(systemName: "shippingbox"), tag: 2)
        viewControllers = [balanceViewController, objectiveViewController, moneyBoxViewController ]
    }
}
