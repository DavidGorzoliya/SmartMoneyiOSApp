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
// получения обьекта с реалма
    private var allDeposits: [Deposit] {
        realm.objects(Deposit.self).map({ $0 })
    }

    var childrensPiggyBankDeposits: [Deposit] {
        Array(allDeposits.dropFirst(57))
    }

    var weeksOfWealthDeposits: [Deposit] {
        Array(allDeposits.dropLast(100))
    }

    var balance: Balance {
        realm.objects(Balance.self).first!
    }
    
    var balanceWeeksOfWealth: BalanceWeeksOfWealth {
        realm.objects(BalanceWeeksOfWealth.self).first!
    }
    
    var getAllObjectives: [Objective] {
        realm.objects(Objective.self).map({ $0 })
    }

    private init() {
        if realm.objects(Deposit.self).isEmpty {
            do {
                try realm.write {
                    realm.add(Deposit.generateWeeksOfWealthDeposits())
                    realm.add(Deposit.generateChildrensPiggyBankDeposits())
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
        
        if realm.objects(BalanceWeeksOfWealth.self).isEmpty {
            do {
                try realm.write {
                    realm.add(BalanceWeeksOfWealth())
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

// MARK: - Balance
extension BackendManager {
    func addToBalance(amount: Int) {
        guard let deposit = realm.objects(Balance.self).first,
              amount > 0 else {
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

    func subtractFromBalance(amount: Int) {
        guard let deposit = realm.objects(Balance.self).first,
              amount > 0 else {
            return
        }
        do {
            try realm.write {
                deposit.amount -= amount
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Balance piggy bank
extension BackendManager {
    func addToBalanceFromWeeksOfWealthPiggyBank(amount: Int) {
        guard let deposit = realm.objects(BalanceWeeksOfWealth.self).first else {
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
    func addObjective(title: String) {
        do {
            try realm.write {
                realm.add(Objective(price: 0, title: title))
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
