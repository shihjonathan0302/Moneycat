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

    var body: some View {
        NavigationView {
            VStack {
                Picker("Time Range", selection: $selectedTimeRange) {
                    ForEach(TimeRange.allCases, id: \.self) { range in
                        Text(range.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // Chart displayed outside of the List
                if let chartData = generateChartData(for: selectedTimeRange) {
                    VerticalBarChartView(data: chartData)
                        .frame(height: 250)
                        .padding([.horizontal, .top], 16)
                } else {
                    Text("No expenses to display. Please add some expenses.")
                        .padding()
                }

                // Divider to separate chart and list
                Divider()
                    .padding(.vertical)

                Spacer().frame(height: 30)

                // Expenses list with swipe-to-delete functionality and rounded corners
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
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let expenseToDelete = realmManager.expenses[index]
                            realmManager.deleteExpense(expenseToDelete)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding()
            .background(Color(.systemGray6)) // Set light gray background for the entire view
            .navigationTitle("Expenses") // Set the title as navigation title
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
            return ChartSegmentData(category: category, amount: percentage, color: .orange) // Adjust color as needed
        }
    }
}
