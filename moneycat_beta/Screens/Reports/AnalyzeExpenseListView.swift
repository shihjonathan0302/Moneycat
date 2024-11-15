//
//  AnalyzeExpenseListView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/13.
//

import SwiftUI
import RealmSwift

struct AnalyzeExpenseListView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var selectedExpense: Expense? = nil
    @State private var showAnalyzeView = false
    @Binding var resetToRoot: Bool // Bind resetToRoot from ReportsView

    var body: some View {
        List {
            ForEach(realmManager.expenses.filter { $0.needOrWant == "Want" && !$0.isInvalidated }) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Expense: \(expense.note)")
                        Text("Amount: \(Int(expense.amount))") // Display amount without decimal
                        if expense.betterCoefficient != 0.0 && expense.worseCoefficient != 0.0 {
                            Text("Analyzed")
                        } else {
                            Text("Not Analyzed")
                        }
                    }
                    Spacer()

                    // Button to analyze each expense
                    Button(action: {
                        if !expense.isInvalidated { // Double-check if expense is valid
                            selectedExpense = expense
                            showAnalyzeView = true
                        } else {
                            print("Attempted to analyze an invalidated expense.")
                        }
                    }) {
                        Text("Analyze")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("Analyze Expenses")
        .navigationDestination(isPresented: $showAnalyzeView) {
            if let expense = selectedExpense, !expense.isInvalidated { // Ensure selectedExpense is valid
                AnalyzeView(expense: expense, resetToRoot: $resetToRoot)
                    .onDisappear {
                        selectedExpense = nil // Clear selected expense after analysis
                        realmManager.loadExpenses() // Refresh expenses after analysis
                    }
            } else {
                // Fallback message if the expense becomes invalidated
                Text("The selected expense is no longer available.")
                    .foregroundColor(.red)
                    .font(.body)
            }
        }
    }
}
