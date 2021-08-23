//
//  BalanceViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

class BalanceViewController: UIViewController {
    
    private var balanceWeekOfWealsLabel : UILabel = {
        
        let balanceWeekOfWealsLable = UILabel()
        balanceWeekOfWealsLable.text = "VOT ON TYT"
        return balanceWeekOfWealsLable
    }()
    
    private var balance: Int = BackendManager.shared.balance.amount {
        didSet {
            title = String(balance)
        }
    }

    private var balanceWeeksOfWealth: Int = BackendManager.shared.balanceAdultPiggyBank.amount {
        didSet {
            balanceWeekOfWealsLabel.text = "\(balanceWeeksOfWealth)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = String(balance)
        layout()
        

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddToBalance))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(systemName: "minus"), style: .plain, target: self, action: #selector(onSubtractFromBalance))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        balanceWeeksOfWealth = BackendManager.shared.balanceAdultPiggyBank.amount
    }

    @objc private func onAddToBalance() {
        let alertController = UIAlertController(title: "Write the amount", message: nil, preferredStyle: .alert)
        alertController.addTextField { $0.keyboardType = .numberPad }

        let addToBalanceAction = UIAlertAction(title: "Add", style: .default) { [unowned alertController] _ in

            guard let textFields = alertController.textFields,
                  let amountTextField = textFields.first,
                  let text = amountTextField.text,
                  let amount = Int(text) else {
                return
            }
            
            BackendManager.shared.addToBalance(amount: amount)
            self.balance = BackendManager.shared.balance.amount
        }

        alertController.addAction(addToBalanceAction)
        present(alertController, animated: true)
    }
    @objc private func onSubtractFromBalance() {
        let alertController = UIAlertController(title: "Write the amount", message: nil, preferredStyle: .alert)
        alertController.addTextField { $0.keyboardType = .numberPad }

        let onSubtractFromBalance = UIAlertAction(title: "Add", style: .default) { [unowned alertController] _ in

            guard let textFields = alertController.textFields,
                  let amountTextField = textFields.first,
                  let text = amountTextField.text,
                  let amount = Int(text) else {
                return
            }
            
            BackendManager.shared.subtractFromBalance(amount: amount)
            self.balance = BackendManager.shared.balance.amount
        }

        alertController.addAction(onSubtractFromBalance)
        present(alertController, animated: true)
    }
    
    private func layout() {
        view.addSubview(balanceWeekOfWealsLabel)
        balanceWeekOfWealsLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceWeekOfWealsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        balanceWeekOfWealsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
