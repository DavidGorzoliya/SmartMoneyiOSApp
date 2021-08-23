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
        /*
         1. Open Finder
         2. Press cmd + shift + G
         3. Paste below path
         
         /Users/davidgorzolia/Library/Developer/CoreSimulator/Devices/1D45DDC3-9A47-4C9B-B286-CAB4AEA9CC27/data/Containers/Data/Application/027DDB52-55BF-4F7A-9E0E-08DB9549440A/Documents/default.realm
        */
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
