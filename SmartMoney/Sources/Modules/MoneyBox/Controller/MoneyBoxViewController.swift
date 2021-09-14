//
//  MoneyBoxViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

private let cellIdentifier = "cell"

class MoneyBoxViewController: UIViewController {
    private var menuItems = ["52 WEEKS OF WEALTH", "CHILDRENS PIGGY BANK"]
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        tableView.pinToSuperview()
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MoneyBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.setupShadow()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = indexPath.row == 0 ? AdultPiggyBankViewController() : KidPiggyBankViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
