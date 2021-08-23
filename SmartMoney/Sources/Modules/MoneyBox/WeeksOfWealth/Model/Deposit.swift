//
//  Deposit.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/14/21.
//

import Foundation
import RealmSwift

class Deposit: Object {
    @objc dynamic var amount: Int = 0
    @objc dynamic var completed: Bool = false

    static func generateWeeksOfWealthDeposits() -> [Deposit] {
        var deposits = [Deposit]()
        for i in stride(from: 100, through: 5700, by: 100) {
            let deposit = Deposit()
            deposit.amount = i
            deposits.append(deposit)
        }
        return deposits
    }
    
    static func generateChildrensPiggyBankDeposits() -> [Deposit] {
        var deposits = [Deposit]()
        for i in stride(from: 1, through: 100, by: 1) {
            let deposit = Deposit()
            deposit.amount = i
            deposits.append(deposit)
        }
        return deposits
    }
}
