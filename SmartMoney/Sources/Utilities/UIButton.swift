//
//  UIButton.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

import UIKit

extension UIButton {

    static func makeWeekOfWealthOptionButton(color: UIColor,title: String = "", target: UIViewController, selector: Selector) -> UIButton {

        let optionButton = UIButton()
        optionButton.addTarget(target, action: selector, for: .touchUpInside)
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        optionButton.backgroundColor = color
        optionButton.setTitleColor(.black, for: .normal)
        optionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        optionButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        optionButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        optionButton.setTitle(title, for: .normal)
        return optionButton
    }
}
