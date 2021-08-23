//
//  Deposit.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/14/21.
//

import Foundation
import RealmSwift

class Coin: Object {
    @objc dynamic var amount: Int = 0
    @objc dynamic var completed: Bool = false

    static func generateAdultPiggyBankCoins() -> [Coin] {
        var coins = [Coin]()
        for i in stride(from: 100, through: 5700, by: 100) {
            let coin = Coin()
            coin.amount = i
            coins.append(coin)
        }
        return coins
    }
    
    static func generateChildrensPiggyBankCoins() -> [Coin] {
        var coins = [Coin]()
        for i in stride(from: 1, through: 100, by: 1) {
            let coin = Coin()
            coin.amount = i
            coins.append(coin)
        }
        return coins
    }
}
