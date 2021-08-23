//
//  ObjectiveViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

private let cellIdentifier = "cell"

class ObjectiveViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var objectives = BackendManager.shared.getAllObjectives {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var insertBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.insert"), style: .plain, target: self, action: #selector(onAddToPriceObjective))

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupTableView()
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
    
    @objc func onAddToPriceObjective() {
        let alertController = UIAlertController(title: "Write the objective", message: nil, preferredStyle: .alert)
        alertController.addTextField { $0.keyboardType = .numberPad }

        let addToPriceObjective = UIAlertAction(title: "Add", style: .default) { [unowned alertController] _ in

            guard let textFields = alertController.textFields,
                  let amountTextField = textFields.first,
                  let text = amountTextField.text,
                  !text.isEmpty else {
                return
            }
            
            BackendManager.shared.addObjective(title: text)
            self.objectives = BackendManager.shared.getAllObjectives
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
        cell.textLabel?.text = objectives[indexPath.row].title
        cell.countingLabel.text = String(objectives[indexPath.row].price)
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            BackendManager.shared.deleteObjective(at: indexPath.row)
            objectives = BackendManager.shared.getAllObjectives
        }
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let travelViewController = TravelViewController()
//            navigationController?.pushViewController(travelViewController, animated: true)
//        } else if indexPath.row == 1 {
//            let studyViewController = StudyViewController()
//            navigationController?.pushViewController(studyViewController, animated: true)
//        } else if indexPath.row == 2 {
//            let purchaseViewController = PurchaseViewController()
//            navigationController?.pushViewController(purchaseViewController, animated: true)
//        }
//    }
}

extension ObjectiveViewController: ObjectiveTableViewCellDelegate {
    func objectiveTableViewCellOnSubmit(_ cell: ObjectiveTableViewCell) {
        let alertController = UIAlertController(title: "Write the price", message: nil, preferredStyle: .alert)
        alertController.addTextField { $0.keyboardType = .numberPad }

        let modifyPriceObjective = UIAlertAction(title: "Add", style: .default) { [unowned alertController] _ in

            guard let textFields = alertController.textFields,
                  let amountTextField = textFields.first,
                  let text = amountTextField.text,
                  let price = Int(text) else {
                return
            }

            BackendManager.shared.modifyObjective(price: price, title: cell.textLabel!.text!)
            self.objectives = BackendManager.shared.getAllObjectives
        }

        alertController.addAction(modifyPriceObjective)
        present(alertController, animated: true)
    }
}
