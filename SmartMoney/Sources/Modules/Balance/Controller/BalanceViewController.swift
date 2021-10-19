//
//  BalanceViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

final class BalanceViewController: UIViewController {

    private enum OperationType {
        case add
        case subtract
    }

    private var balanceView: BalanceView {
        return view as! BalanceView
    }

    override func loadView() {
        view = BalanceView()
    }

    private var balance: Int = BackendManager.shared.balance.amount {
        didSet {
            title = String(balance)
        }
    }

    private var balanceAdultPiggyBank: Int = BackendManager.shared.balanceAdultPiggyBank.amount {
        didSet {
            balanceView.weeksOfWealth.subtitleLabel.text = "\(balanceAdultPiggyBank) OF 137800"
        }
    }

    private var balanceKidPiggyBank: Int = BackendManager.shared.balanceKidPiggyBank.amount {
        didSet {
            balanceView.childrenPiggyBank.subtitleLabel.text = "\(balanceKidPiggyBank) OF 5050"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = String(balance)

        setUpNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        balanceAdultPiggyBank = BackendManager.shared.balanceAdultPiggyBank.amount
        balanceKidPiggyBank = BackendManager.shared.balanceKidPiggyBank.amount
    }

    private func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(onAddToBalance))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "minus"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onSubtractFromBalance))
    }

    @objc private func onAddToBalance() {
        onBalanceChange(operationType: .add)
    }

    @objc private func onSubtractFromBalance() {
        onBalanceChange(operationType: .subtract)
    }

    private func onBalanceChange(operationType: OperationType) {
        let alertController = UIAlertController.makeSMAlertController(title: "Write the amount")
        alertController.addTextField { $0.keyboardType = .numberPad }

        let addToBalanceAction = UIAlertAction(title: "Done", style: .default) { _ in

            guard let textFields = alertController.textFields,
                  let amountTextField = textFields.first,
                  let text = amountTextField.text,
                  let amount = Int(text) else {
                return
            }

            BackendManager.shared.changeBalance(amount: operationType == .add ? amount : -amount)
            self.balance = BackendManager.shared.balance.amount
        }

        alertController.addAction(addToBalanceAction)
        present(alertController, animated: true)
    }
}
