//
//  Deposit.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/14/21.
//

import Foundation

class Deposit {
    
    let amount: Int
    var completed: Bool
    
    init(amount: Int, completed: Bool = false) {
        self.amount = amount
        self.completed = completed
    }
    
}
