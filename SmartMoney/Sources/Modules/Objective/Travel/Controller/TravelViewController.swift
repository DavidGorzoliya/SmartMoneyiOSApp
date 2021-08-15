//
//  TravelViewController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/14/21.
//

import UIKit

private let cellIdentifier = "cell"

class TravelViewController: UIViewController {
    
    let tableView = UITableView()
    
    private var names = ["1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUpTableView()
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }

    private func setUpTableView() {
        tableView.register(TravelViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TravelViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = names[indexPath.row]

        return cell
    }
}
