//
//  ExpenseCategory.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI
import RealmSwift

class ExpenseCategory: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String = ""
    @Persisted var color: PersistableColor?  // Color persistence using the PersistableColor class

    convenience init(name: String, color: PersistableColor) {
        self.init()
        self.name = name
        self.color = color
    }
}
