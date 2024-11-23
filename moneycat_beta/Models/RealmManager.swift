//
//  RealmManager.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/8.
//

import RealmSwift
import SwiftUI

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?

    @Published var expenses: [Expense] = []
    @Published var categories: [ExpenseCategory] = []
    @Published var isDarkMode: Bool = false
    @Published var updateTrigger: Bool = false  // Trigger property to force update
    
    init() {
        openRealm()
        refreshExpenses()
        loadCategories()
        addDefaultCategoriesIfNeeded()
    }

    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 3)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
            print("Realm opened successfully")
        } catch {
            print("Error opening Realm: \(error.localizedDescription)")
        }
    }

    func eraseData() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.deleteAll()
                    expenses.removeAll()
                    categories.removeAll()
                    print("All data erased.")
                }
                updateTrigger.toggle() // Notify observers of the change
            } catch {
                print("Error erasing data: \(error.localizedDescription)")
            }
        }
    }

    func updateExpense(expense: Expense, better: Double, worse: Double, dimension: String) {
        guard let localRealm = localRealm, !expense.isInvalidated else { return }

        do {
            try localRealm.write {
                expense.betterCoefficient = better
                expense.worseCoefficient = worse
                expense.dimension = dimension
            }
            print("Updated Expense: \(expense.note)")
            updateTrigger.toggle() // Notify observers without reloading all expenses
        } catch {
            print("Error updating expense: \(error)")
        }
    }
 
//    func loadExpenses() {
//        if let localRealm = localRealm {
//            let allExpenses = localRealm.objects(Expense.self).filter { !$0.isInvalidated }
//            expenses = Array(allExpenses)
//            observedExpenses = expenses // Synchronize observed expenses
//            print("Loaded \(expenses.count) expenses")
//        }
//    }

    func deleteExpense(_ expense: Expense) {
        guard let localRealm = localRealm, !expense.isInvalidated else { return }

        do {
            try localRealm.write {
                localRealm.delete(expense)
            }
            refreshExpenses() // Unified refresh
            print("Expense deleted")
        } catch {
            print("Error deleting expense: \(error.localizedDescription)")
        }
    }


    func loadCategories() {
        if let localRealm = localRealm {
            let allCategories = localRealm.objects(ExpenseCategory.self)
            categories = Array(allCategories)
            print("Loaded \(categories.count) categories")
        }
    }

    func addDefaultCategoriesIfNeeded() {
        if categories.isEmpty {
            let defaultCategories = [
                ExpenseCategory(name: "Food", color: PersistableColor(color: Color.red)),
                ExpenseCategory(name: "Rent", color: PersistableColor(color: Color.yellow)),
                ExpenseCategory(name: "Utilities", color: PersistableColor(color: Color.teal)),
                ExpenseCategory(name: "Transportation", color: PersistableColor(color: Color.purple))
            ]
            for category in defaultCategories {
                submitCategory(category)
            }
        }
    }

    func submitExpense(_ expense: Expense) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    // Ensure expense is not already present
                    if !localRealm.objects(Expense.self).contains(where: { $0.id == expense.id }) {
                        localRealm.add(expense)
                    }
                }
                refreshExpenses()
                print("Expense submitted: \(expense.note)")
            } catch {
                print("Error submitting expense to Realm: \(error.localizedDescription)")
            }
        }
    }

    func submitCategory(_ category: ExpenseCategory) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    // Ensure category is not already present
                    if !localRealm.objects(ExpenseCategory.self).contains(where: { $0.id == category.id }) {
                        localRealm.add(category)
                    }
                }
                loadCategories()
                print("Category submitted: \(category.name)")
            } catch {
                print("Error submitting category to Realm: \(error.localizedDescription)")
            }
        }
    }

    func calculateDimension(better: Double, worse: Double) -> String {
        if better > 50 && worse < -50 {
            return "Attractive"
        } else if better > 50 {
            return "One-Dimensional"
        } else if worse < -50 {
            return "Must"
        } else {
            return "Indifferent"
        }
    }
    
    func refreshExpenses() {
        guard let localRealm = localRealm else { return }

        print("Refreshing all expenses")
        let allExpenses = localRealm.objects(Expense.self).filter { !$0.isInvalidated }
        expenses = Array(allExpenses)
        print("Refreshed \(expenses.count) expenses")
        updateTrigger.toggle() // Notify observers of the change
    }

    
//    func loadObservedExpenses() {
//        if let localRealm = localRealm {
//            observedExpenses = Array(localRealm.objects(Expense.self).filter { !$0.isInvalidated })
//        }
//    }
}
