//
//  MoneyBoxViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

class Wallet {
    private var balance: Double = 0.0
    private var piggyBank: Double = 0.0

    func addToTheBalance(_ amount: Double) {
        guard amount > 0.0 else {
            print("КАК ТЫ СОБРАЛСЯ ДОБАВЛЯТЬ ОТРИЦАТЕЛЬНЫЕ БАБКИ?!")
            return
        }

        balance += amount
        print("БАЛАНС УСПЕШНО ПОПОЛНЕН!!!")
    }
}

class MoneyBoxViewController: UIViewController {
    
    lazy var transitionWealthWeekButton: UIButton = {
        let transitionWealthWeekButton = UIButton()
        transitionWealthWeekButton.addTarget(self, action: #selector(transitionButton), for: .touchUpInside)
        transitionWealthWeekButton.backgroundColor = .white
        transitionWealthWeekButton.setTitleColor(.black, for: .normal)
        transitionWealthWeekButton.titleLabel?.adjustsFontSizeToFitWidth = true
        transitionWealthWeekButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        transitionWealthWeekButton.setTitle("  52 WEEKS OF WEALTH  ", for: .normal)
        transitionWealthWeekButton.layer.cornerRadius = 8
        transitionWealthWeekButton.dropShadow(shadowRadius: 2)
        
        return transitionWealthWeekButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        layout()
    }
    
    @objc func transitionButton() {
        let weeksOfWealthViewController = WeeksOfWealthViewController()
        navigationController?.pushViewController(weeksOfWealthViewController, animated: true)
    }
    
    func layout() {
        view.addSubview(transitionWealthWeekButton)
        transitionWealthWeekButton.translatesAutoresizingMaskIntoConstraints = false
        transitionWealthWeekButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        transitionWealthWeekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
