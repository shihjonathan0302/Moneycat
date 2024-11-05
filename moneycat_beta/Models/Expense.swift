//
//  Expense.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import RealmSwift
import Foundation

class Expense: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var amount: Double
    @Persisted var category: ExpenseCategory?  // Optional, relates to ExpenseCategory
    @Persisted var recurrence: String
    @Persisted var date: Date
    @Persisted var note: String
    @Persisted var needOrWant: String  // "Need" or "Want" field
    
    @Persisted var betterCoefficient: Double = 0.0
    @Persisted var worseCoefficient: Double = 0.0
}
