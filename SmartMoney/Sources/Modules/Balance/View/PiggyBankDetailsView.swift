//
//  PiggyBankDetailsView.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 9/9/21.
//

import Foundation
import UIKit

class PiggyBankDetailsView: UIView {
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.setupShadow()

        return titleLabel
    }()

    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "subtitle"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.setupShadow()

        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

