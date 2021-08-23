//
//  Objective.swift
//  SmartMoney
//
//  Created by Давид Горзолия on 8/19/21.
//

import Foundation
import RealmSwift

class Objective: Object {
    @objc dynamic var price: Int = 0
    @objc dynamic var title: String = "_"
    
    convenience init(price: Int, title: String) {
        self.init()
        self.price = price
        self.title = title
    }
}
