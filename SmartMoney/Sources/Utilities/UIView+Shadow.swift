//
//  UIView+Shadow.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/10/21.
//

// ДЕТАЛИС!!!argumtent

import Foundation
import UIKit

extension UIView {
    func dropShadow(shadowRadius: CGFloat = 3) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = shadowRadius
    }
}
