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
            ForEach(realmManager.expenses.filter { $0.needOrWant == "Want" }) { expense in
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
                        selectedExpense = expense
                        showAnalyzeView = true
                    }) {
                        Text("Analyze")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("Analyze Expenses")
        .navigationDestination(isPresented: $showAnalyzeView) {
            if let expense = selectedExpense {
                AnalyzeView(expense: expense, resetToRoot: $resetToRoot)
            }
        }
     }
}
