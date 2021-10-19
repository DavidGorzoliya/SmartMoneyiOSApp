//
//  ObjectiveViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit
import TableViewReloadAnimation

private let cellIdentifier = "cell"

class ObjectiveViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var objectives = BackendManager.shared.objectives {
        didSet {
            tableView.reloadData(with: .spring(duration: 0.45,
                                               damping: 0.65,
                                               velocity: 1,
                                               direction: .rotation(angle: Double.pi / 2),
                                               constantDelay: 0))
        }
    }

    private lazy var insertBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.insert"), style: .plain, target: self, action: #selector(onAddToPriceObjective))

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinToSuperview()
        navigationItem.rightBarButtonItem = insertBarButtonItem
        
    }

    private func setupTableView() {
        tableView.register(ObjectiveTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    @objc private func onAddToPriceObjective() {
        let alertController = UIAlertController.makeSMAlertController(title: "Write the objective and price")
        alertController.addTextField { $0.placeholder = "Title" }
        alertController.addTextField {
            $0.keyboardType = .numberPad
            $0.placeholder = "Price"
        }

        let addToPriceObjective = UIAlertAction(title: "Add", style: .default) { [unowned alertController] _ in

            guard let textFields = alertController.textFields,
                  let titleTextField = textFields.first,
                  let text = titleTextField.text,
                  !text.isEmpty,
                  let priceTextField = textFields.last,
                  let priceText = priceTextField.text,
                  let price = Int(priceText) else {
                return
            }
            
            BackendManager.shared.addObjective(title: text, price: price)
            self.objectives = BackendManager.shared.objectives
        }

        alertController.addAction(addToPriceObjective)
        present(alertController, animated: true)
    }
}

extension ObjectiveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectives.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ObjectiveTableViewCell else {
            return UITableViewCell()
        }

        let balance = BackendManager.shared.balance.amount

        cell.textLabel?.text = objectives[indexPath.row].title
        cell.textLabel?.setupShadow()
        cell.priceLabel.text = String(objectives[indexPath.row].price)
        cell.balanceLabel.text = "\(balance)"

        var percent: CGFloat = 0
        if objectives[indexPath.row].price < balance {
            percent = 90
        } else if objectives[indexPath.row].price != 0 && balance >= 0 {
            percent = CGFloat(balance) / CGFloat(objectives[indexPath.row].price) * 90.0
        }
        cell.progressBarView.frame.size.width = percent

        if balance >= objectives[indexPath.row].price {
            cell.balanceLabel.textColor = .SMGreen
        } else {
            cell.balanceLabel.textColor = .red
        }
        cell.price = objectives[indexPath.row].price
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            BackendManager.shared.deleteObjective(at: indexPath.row)
            objectives = BackendManager.shared.objectives
        }
    }
}

extension ObjectiveViewController: ObjectiveTableViewCellDelegate {
    func objectiveTableViewCellOnSubmit(_ cell: ObjectiveTableViewCell) {
        let alertController = UIAlertController.makeSMAlertController(title: "Write the price")
        alertController.addTextField { $0.keyboardType = .numberPad }

        let modifyPriceObjective = UIAlertAction(title: "Edit", style: .default) { [unowned alertController] _ in

            guard let textFields = alertController.textFields,
                  let amountTextField = textFields.first,
                  let text = amountTextField.text,
                  let price = Int(text) else {
                return
            }

            BackendManager.shared.modifyObjective(price: price, title: cell.textLabel!.text!)
            self.objectives = BackendManager.shared.objectives
        }

        alertController.addAction(modifyPriceObjective)
        present(alertController, animated: true)
    }
}
