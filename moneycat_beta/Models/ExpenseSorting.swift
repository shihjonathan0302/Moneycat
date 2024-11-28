//
//  ExpenseSorting.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/11/28.
//

//import Foundation
//
//enum SortOption: String, CaseIterable {
//    case dateDescending = "Date (Newest)"
//    case dateAscending = "Date (Oldest)"
//    case amountDescending = "Amount (High to Low)"
//    case amountAscending = "Amount (Low to High)"
//    case category = "Category"
//}
//
//class ExpenseSorting {
//    static func sortExpenses(_ expenses: [Expense], by option: SortOption) -> [Expense] {
//        return expenses.sorted {
//            switch option {
//            case .dateDescending:
//                return $0.date > $1.date
//            case .dateAscending:
//                return $0.date < $1.date
//            case .amountDescending:
//                return $0.amount > $1.amount
//            case .amountAscending:
//                return $0.amount < $1.amount
//            case .category:
//                return ($0.category?.name ?? "") < ($1.category?.name ?? "")
//            }
//        }
//    }
//}
