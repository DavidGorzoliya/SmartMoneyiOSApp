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
    
    private let objectives = ["Travel", "Study", "Purchase"]
    
    private let images = [UIImage(named: "travel"), UIImage(named: "study"), UIImage(named: "purchase")]

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupTableView()
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }

    private func setupTableView() {
        tableView.register(ObjectiveTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
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
        cell.textLabel?.text = objectives[indexPath.row]
        cell.objectiveItemImageView.image = images[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let travelViewController = TravelViewController()
            navigationController?.pushViewController(travelViewController, animated: true)
        } else if indexPath.row == 1 {
            let studyViewController = StudyViewController()
            navigationController?.pushViewController(studyViewController, animated: true)
        } else if indexPath.row == 2 {
            let purchaseViewController = PurchaseViewController()
            navigationController?.pushViewController(purchaseViewController, animated: true)
        }
    }
}

