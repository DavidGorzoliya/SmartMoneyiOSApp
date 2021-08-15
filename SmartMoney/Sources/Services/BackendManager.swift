//
//  BackendManager.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/15/21.
//

import Foundation
import RealmSwift

class BackendManager {
    static let shared = BackendManager()
    private let realm = try! Realm()

    private init() {
        if realm.objects(Deposit.self).isEmpty {
            prepareDeposits()
        }
    }

    private func prepareDeposits() {
        for i in stride(from: 100, through: 5700, by: 100) {
            let deposit = Deposit()
            deposit.amount = i
            do {
                try realm.write {
                    realm.add(deposit)
                }
            } catch {
                print(error)
            }
        }
    }

    func getAllDeposits() -> [Deposit] {
        return realm.objects(Deposit.self).map({ $0 })
    }

    func modifyDeposit(with amount: Int) -> Deposit {
        let deposit = realm.objects(Deposit.self).first(where: { $0.amount == amount })!
        do {
            try realm.write {
                deposit.completed = !deposit.completed
            }
        } catch {
            print(error)
        }
        return deposit
    }
}
