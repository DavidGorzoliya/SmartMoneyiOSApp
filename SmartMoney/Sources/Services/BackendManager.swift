//
//  BackendManager.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/15/21.
//

// cmd + shift + O open file

import Foundation
import RealmSwift

class BackendManager {
    static let shared = BackendManager()
    private let realm = try! Realm()

    private var coins: [Coin] {
        realm.objects(Coin.self).map({ $0 })
    }

    var kidPiggyBankCoins: [Coin] {
        Array(coins.dropFirst(57))
    }

    var adultPiggyBankCoins: [Coin] {
        Array(coins.dropLast(100))
    }

    var balance: Balance {
        realm.objects(Balance.self).first!
    }
    
    var balanceAdultPiggyBank: BalanceAdultPiggyBank {
        realm.objects(BalanceAdultPiggyBank.self).first!
    }
    
    var balanceKidPiggyBank: BalansKidPiggyBank {
        realm.objects(BalansKidPiggyBank.self).first!
    }
    
    var objectives: [Objective] {
        realm.objects(Objective.self).map({ $0 })
    }

    private init() {
        if realm.objects(Coin.self).isEmpty {
            do {
                try realm.write {
                    realm.add(Coin.generateAdultPiggyBankCoins())
                    realm.add(Coin.generateChildrensPiggyBankCoins())
                }
            } catch {
                print(error)
            }
        }
        
        if realm.objects(BalansKidPiggyBank.self).isEmpty {
            do {
                try realm.write {
                    realm.add(BalansKidPiggyBank())
                }
            } catch {
                print(error)
            }
        }
        
        if realm.objects(Balance.self).isEmpty {
            do {
                try realm.write {
                    realm.add(Balance())
                }
            } catch {
                print(error)
            }
        }
        
        if realm.objects(BalanceAdultPiggyBank.self).isEmpty {
            do {
                try realm.write {
                    realm.add(BalanceAdultPiggyBank())
                }
            } catch {
                print(error)
            }
        }

        if realm.objects(Objective.self).isEmpty {
            do {
                try realm.write {
                    realm.add([Objective(price: 0, title: "PRESENT"),
                               Objective(price: 0, title: "IPHONE"),
                               Objective(price: 0, title: "CAR"),
                               Objective(price: 0, title: "HOUSE"),
                               Objective(price: 0, title: "TRAVEL"),
                               Objective(price: 0, title: "STUDY"),
                               Objective(price: 0, title: "COMPUTER"),
                               Objective(price: 0, title: "BIKE")])
                }
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Piggy bank
extension BackendManager {
    func modifyChildrensPiggyBankCoinCompletion(coinWithAmount amount: Int) -> Coin? {
        guard let coin = kidPiggyBankCoins.first(where: { $0.amount == amount}) else {
            return nil
        }
        
        do {
            try realm.write {
                coin.completed = !coin.completed
            }
        } catch {
            print(error)
            return nil
        }
    
        return coin
    }

    func modifyAdultPiggyBankCoinCompletion(coinWithAmount amount: Int) -> Coin? {
        guard let coin = adultPiggyBankCoins.first(where: { $0.amount == amount}) else {
            return nil
        }

        do {
            try realm.write {
                coin.completed = !coin.completed
            }
        } catch {
            print(error)
            return nil
        }

        return coin
    }
}

// MARK: - Balance
extension BackendManager {
    func changeBalance(amount: Int) {
        guard let deposit = realm.objects(Balance.self).first else {
            return
        }
        do {
            try realm.write {
                deposit.amount += amount
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Balance piggy bank
extension BackendManager {
    func addToBalanceFromAdultPiggyBank(amount: Int) {
        guard let deposit = realm.objects(BalanceAdultPiggyBank.self).first else {
            return
        }
        do {
            try realm.write {
                deposit.amount += amount
            }
        } catch {
            print(error)
        }
    }
    
    func addToBalanceFromKidPiggyBank(amount: Int) {
        guard let deposit = realm.objects(BalansKidPiggyBank.self).first else {
            return
        }
        do {
            try realm.write {
                deposit.amount += amount
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Objective
extension BackendManager {
    func addObjective(title: String, price: Int) {
        guard price > 0 else {
            print("Price cannot be less than zero")
            return
        }
        do {
            try realm.write {
                realm.add(Objective(price: price, title: title))
            }
        } catch {
            print(error)
        }
    }

    func modifyObjective(price: Int, title: String) {
        guard let objective = realm.objects(Objective.self).first(where: { $0.title == title }) else {
            return
        }
        do {
            try realm.write {
                objective.price = price
            }
        } catch {
            print(error)
        }
    }

    func deleteObjective(at index: Int) {
        do {
            try realm.write {
                realm.delete(realm.objects(Objective.self)[index])
            }
        } catch {
            print(error)
        }
    }

}


