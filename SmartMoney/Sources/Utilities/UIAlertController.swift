//
//  UIAlertController.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 9/4/21.
//

import Foundation
import UIKit

extension UIAlertController {
    static func makeSMAlertController(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        return alertController
    }
}
