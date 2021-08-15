//
//  ObjectiveTableViewCell.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/14/21.
//

import UIKit

class ObjectiveTableViewCell: UITableViewCell {
    
    let objectiveItemImageView: UIImageView = {
        let objectiveItemImageView = UIImageView()
        objectiveItemImageView.backgroundColor = .darkGray
        return objectiveItemImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(objectiveItemImageView)
        objectiveItemImageView.translatesAutoresizingMaskIntoConstraints = false
        objectiveItemImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        objectiveItemImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        objectiveItemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        objectiveItemImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
}
