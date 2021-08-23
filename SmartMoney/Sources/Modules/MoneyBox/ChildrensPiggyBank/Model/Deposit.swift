//
//  Deposit.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/18/21.
//

import Foundation
import RealmSwift

class Deposit: Object {
    @objc dynamic var amount: Int = 0
    @objc dynamic var completed: Bool = false
}
