//
//  ObjectiveTableViewCell.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/14/21.
//

import UIKit

protocol ObjectiveTableViewCellDelegate: AnyObject {
    func objectiveTableViewCellOnSubmit(_ cell: ObjectiveTableViewCell )
}

class ObjectiveTableViewCell: UITableViewCell {
    
    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(handliUpdate))
    weak var delegate: ObjectiveTableViewCellDelegate?
    
    private var counter = 0
    private var price = 0
    
    let countingLabel: UILabel = {
        let countingLabel = UILabel()
        countingLabel.text = "0"
        
        return countingLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func onTap() {
        delegate?.objectiveTableViewCellOnSubmit(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(countingLabel)
        countingLabel.translatesAutoresizingMaskIntoConstraints = false
        countingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        countingLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }
    
    private func prepareDisplayLink() {
        displayLink.add(to: .main, forMode: .default)
    
    }
    
    @objc func handliUpdate() {
        if counter >= BackendManager.shared.balance.amount {
            displayLink.isPaused = true
            countingLabel.text = "\(BackendManager.shared.balance.amount)"
        } else {
            counter += 100
            countingLabel.text = "\(counter)"
        }
    }
}
