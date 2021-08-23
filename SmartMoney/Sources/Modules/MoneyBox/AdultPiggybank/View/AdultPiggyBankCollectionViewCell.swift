//
//  WeeksOfWealthCollectionViewCell.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

// How to play a sound using Swift GOOGLE
//

import UIKit

protocol AdultPiggyBankCollectionViewCellDelegate: AnyObject {
    func adultPiggyBankCollectionViewCellTapped(_ cell: AdultPiggyBankCollectionViewCell)
}

class AdultPiggyBankCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: AdultPiggyBankCollectionViewCellDelegate?
    
    lazy var coinAmountLabel: UILabel = {
        let coinAmountLabel = UILabel()
        coinAmountLabel.font = UIFont.boldSystemFont(ofSize: 18)
        coinAmountLabel.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(onWeeksOfWealthCollectionViewCellTap))
        coinAmountLabel.addGestureRecognizer(tap)

        return coinAmountLabel
    }()
    

    lazy var coinView: UIView = {
        let coinView = UIView()
        coinView.translatesAutoresizingMaskIntoConstraints = false
        coinView.widthAnchor.constraint(equalToConstant: 68).isActive = true
        coinView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        coinView.layer.cornerRadius = 68/2
        coinView.backgroundColor = .white
        coinView.dropShadow()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onWeeksOfWealthCollectionViewCellTap))
        coinView.addGestureRecognizer(tap)

        return coinView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onWeeksOfWealthCollectionViewCellTap() {
        delegate?.adultPiggyBankCollectionViewCellTapped(self)
    }

    private func layout() {
        contentView.addSubview(coinView)
        coinView.pinToSuperview()

        contentView.addSubview(coinAmountLabel)
        coinAmountLabel.centerInSuperview()
    }
}

