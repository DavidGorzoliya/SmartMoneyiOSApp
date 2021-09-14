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
    
    weak var delegate: ObjectiveTableViewCellDelegate?
    var price = 0
    
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "0"
        
        return priceLabel
    }()
    
    let progressBarContainerView: UIView = {
        let progressBarContainerView = UIView()
        progressBarContainerView.backgroundColor = .systemGray3
        progressBarContainerView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        progressBarContainerView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        progressBarContainerView.layer.cornerRadius = 20/4
        
        return progressBarContainerView
    }()
    
    let progressBarView: UIView = {
        let progressBarView = UIView()
        progressBarView.backgroundColor = .SMGreen
        progressBarView.layer.cornerRadius = 20/4
        
        return progressBarView
    }()
    
    let balanceLabel = UILabel()
    
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
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        contentView.addSubview(balanceLabel)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        balanceLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -30).isActive = true

        contentView.addSubview(progressBarContainerView)
        progressBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        progressBarContainerView.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10).isActive = true
        progressBarContainerView.rightAnchor.constraint(equalTo: priceLabel.rightAnchor).isActive = true

        contentView.addSubview(progressBarView)
        progressBarView.frame = CGRect(x: 288.0,
                                       y: 60.33333333333334,
                                       width: 0,
                                       height: 15)
    }
}
