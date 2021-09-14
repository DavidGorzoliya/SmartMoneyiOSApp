//
//  ChildrensPiggyBankCollectionViewCell.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/18/21.
//

import UIKit

protocol ChildrensPiggyBankCollectionViewCellDelegate: AnyObject {
    
    func childrensPiggyBankCollectionViewCellTapped(_ cell: ChildrensPiggyBankCollectionViewCell)
}

class ChildrensPiggyBankCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ChildrensPiggyBankCollectionViewCellDelegate?
    
    lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.font = UIFont.boldSystemFont(ofSize: 18)
        amountLabel.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(onChildrensPiggyBankViewCellTap))
        amountLabel.addGestureRecognizer(tap)

        return amountLabel
    }()
    

    lazy var artworkView: UIView = {
        let artworkView = UIView()
        artworkView.translatesAutoresizingMaskIntoConstraints = false
        artworkView.widthAnchor.constraint(equalToConstant: 68).isActive = true
        artworkView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        artworkView.layer.cornerRadius = 68/2
        artworkView.backgroundColor = .white
        artworkView.dropShadow()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onChildrensPiggyBankViewCellTap))
        artworkView.addGestureRecognizer(tap)

        return artworkView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onChildrensPiggyBankViewCellTap() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: amountLabel.text!)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

        delegate?.childrensPiggyBankCollectionViewCellTapped(self)
    }

    private func layout() {
        contentView.addSubview(artworkView)
        artworkView.pinToSuperview()

        contentView.addSubview(amountLabel)
        amountLabel.centerInSuperview()
    }
}

