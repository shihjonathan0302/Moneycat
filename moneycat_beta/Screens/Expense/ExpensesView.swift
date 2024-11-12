//
//  ExpensesView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct ExpensesView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var selectedTimeRange: TimeRange = .month
    @State private var showingEditExpenseSheet = false
    @State private var selectedExpense: Expense? = nil
    @State private var showDeleteConfirmation = false // State to show confirmation alert

    var body: some View {
        VStack {
            Picker("Time Range", selection: $selectedTimeRange) {
                ForEach(TimeRange.allCases, id: \.self) { range in
                    Text(range.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            if let chartData = generateChartData(for: selectedTimeRange) {
                VerticalBarChartView(data: chartData)
                    .frame(height: 250)
                    .padding([.horizontal, .top], 16)
            } else {
                Text("No expenses to display. Please add some expenses.")
                    .padding()
            }

            Divider()
                .padding(.vertical)

            Spacer().frame(height: 30)

            List {
                ForEach(realmManager.expenses) { expense in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(expense.note)
                            .font(.headline)
                        Text("Amount: \(expense.amount, specifier: "%.0f")")
                        Text("Category: \(expense.category?.name ?? "Unknown")")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            selectedExpense = expense // Set the selected expense
                            showDeleteConfirmation = true // Show confirmation alert
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGray6))
        .navigationTitle("Expenses")
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Delete Expense"),
                message: Text("Are you sure you want to delete this expense?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let expenseToDelete = selectedExpense {
                        realmManager.deleteExpense(expenseToDelete)
                        selectedExpense = nil // Clear the selected expense
                    }
                },
                secondaryButton: .cancel {
                    selectedExpense = nil // Clear the selected expense if canceled
                }
            )
        }
    }
    func generateChartData(for timeRange: TimeRange) -> [ChartSegmentData]? {
        let filteredExpenses = realmManager.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: timeRange.calendarComponent)
        }
        guard !filteredExpenses.isEmpty else { return nil }

        let total = filteredExpenses.reduce(0) { $0 + $1.amount }
        let groupedByCategory = Dictionary(grouping: filteredExpenses, by: { $0.category?.name ?? "Unknown" })

        return groupedByCategory.map { (category, expenses) in
            let categoryTotal = expenses.reduce(0) { $0 + $1.amount }
            let percentage = categoryTotal / total
            return ChartSegmentData(category: category, amount: percentage, color: .orange)
        }
    }
}
