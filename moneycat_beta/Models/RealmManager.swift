//
//  RealmManager.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import RealmSwift
import SwiftUI

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?

    @Published var expenses: [Expense] = []
    @Published var categories: [ExpenseCategory] = []
    @Published var isDarkMode: Bool = false

    init() {
        openRealm()
        loadExpenses()
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
            } catch {
                print("Error erasing data: \(error.localizedDescription)")
            }
        }
    }

    func updateExpense(expense: Expense, better: Double, worse: Double) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    expense.betterCoefficient = better
                    expense.worseCoefficient = worse
                    print("Updated Expense \(expense.note): Better = \(better), Worse = \(worse)")
                }
            } catch {
                print("Error updating expense: \(error.localizedDescription)")
            }
        }
    }

    func loadExpenses() {
        if let localRealm = localRealm {
            let allExpenses = localRealm.objects(Expense.self).sorted(byKeyPath: "date")
            expenses = Array(allExpenses)
            for expense in expenses {
                print("Expense: \(expense.note), Better: \(expense.betterCoefficient), Worse: \(expense.worseCoefficient)")
            }
            print("Loaded \(expenses.count) expenses")
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
                ExpenseCategory(name: "Food", color: PersistableColor(color: Color(hex: "#FF6347"))),
                ExpenseCategory(name: "Rent", color: PersistableColor(color: Color(hex: "#4682B4"))),
                ExpenseCategory(name: "Utilities", color: PersistableColor(color: Color(hex: "#9ACD32"))),
                ExpenseCategory(name: "Transportation", color: PersistableColor(color: Color(hex: "#FFD700")))
            ]
            for category in defaultCategories {
                submitCategory(category)
            }
        }
    }

    func submitCategory(_ category: ExpenseCategory) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(category)
                    loadCategories()
                    print("Category submitted: \(category.name)")
                }
            } catch {
                print("Error submitting category to Realm: \(error.localizedDescription)")
            }
        }
    }

    func submitExpense(_ expense: Expense) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(expense)
                    loadExpenses()
                    print("Expense submitted: \(expense.note)")
                }
            } catch {
                print("Error submitting expense to Realm: \(error.localizedDescription)")
            }
        }
    }
    func determineDimensionForExpense(_ expense: Expense) -> String {
            if expense.amount <= 50 {
                return "Basic Needs"
            } else if expense.amount > 50 && expense.amount <= 100 {
                return "Performance Needs"
            } else if expense.amount > 100 && expense.amount <= 150 {
                return "Excitement Needs"
            } else {
                return "Indifferent Needs"
            }
        }
}
