//
//  BalanceView.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 9/9/21.
//

import UIKit

class BalanceView: UIView {

    let weeksOfWealth = PiggyBankDetailsView()
    let childrenPiggyBank = PiggyBankDetailsView()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()

    init() {
        super.init(frame: .zero)
        weeksOfWealth.titleLabel.text = "WEEKS OF WEALTH"
        childrenPiggyBank.titleLabel.text = "CHILDREN PIGGY BANK"
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. We aren't using storyboards")
    }

    private func layout() {
        addSubview(scrollView)
        scrollView.pinToSuperview()

        scrollView.addSubview(scrollContentView)
        scrollContentView.pinToSuperview()
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        let vStackView = UIStackView(arrangedSubviews: [weeksOfWealth, childrenPiggyBank])
        vStackView.axis = .vertical
        vStackView.alignment = .leading
        vStackView.spacing = 4

        scrollContentView.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 24).isActive = true
        vStackView.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor, constant: 10).isActive = true
        vStackView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor, constant: -10).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor).isActive = true
    }
}
