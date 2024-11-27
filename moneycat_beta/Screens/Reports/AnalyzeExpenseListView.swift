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
        let groupedExpenses = Dictionary(grouping: realmManager.expenses.filter {
            $0.needOrWant == "Want" && !$0.isInvalidated
        }) { expense in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy" // Group by "Month Year" format
            return formatter.string(from: expense.date)
        }
        let sortedMonths = groupedExpenses.keys.sorted { $0 > $1 } // Sort months in descending order

        List {
            ForEach(sortedMonths, id: \.self) { month in
                Section(header: Text(month)
                    .font(.headline)
                ) {
                    ForEach(groupedExpenses[month]!.sorted(by: { $0.date > $1.date }), id: \.id) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Expense: \(expense.note)")
                                Text("Amount: \(Int(expense.amount))") // Display amount without decimal
                            }
                            Spacer()

                            // Button as "Analyzed" or "Not Analyzed" with color
                            Button(action: {
                                if !expense.isInvalidated {
                                    selectedExpense = expense
                                    showAnalyzeView = true
                                } else {
                                    print("Attempted to analyze an invalidated expense.")
                                }
                            }) {
                                Text(expense.betterCoefficient != 0.0 && expense.worseCoefficient != 0.0 ? "Analyzed" : "Not Analyzed")
                                    .font(.headline)
                                    .foregroundColor(expense.betterCoefficient != 0.0 && expense.worseCoefficient != 0.0 ? .green : .red)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.vertical, 8) // Add vertical spacing between rows
                    }
                }
            }
        }
        .navigationTitle("Analyze Expenses")
        .navigationDestination(isPresented: $showAnalyzeView) {
            if let expense = selectedExpense, !expense.isInvalidated {
                AnalyzeView(expense: expense, resetToRoot: $resetToRoot)
                    .onDisappear {
                        selectedExpense = nil
                        realmManager.refreshExpenses()
                    }
            } else {
                Text("The selected expense is no longer available.")
                    .foregroundColor(.red)
                    .font(.body)
            }
        }
    }
}
