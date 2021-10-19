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
    
    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.masksToBounds = false
    }
}


