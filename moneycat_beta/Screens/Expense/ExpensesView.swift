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
    
    var body: some View {
        VStack {
            Text("Expenses")
                .font(.title.bold())
                .padding(.top)
            
            Picker("Time Range", selection: $selectedTimeRange) {
                ForEach(TimeRange.allCases, id: \.self) { range in
                    Text(range.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // Use BarChartView instead of PieChartView
            if let chartData = generateChartData(for: selectedTimeRange) {
                BarChartView(data: chartData) // Ensure BarChartView is properly defined
                    .frame(height: 250)
                    .padding()
            } else {
                Text("No expenses to display. Please add some expenses.") // More user-friendly message
                    .padding()
            }

            List(realmManager.expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.note)
                        Text("Amount: \(expense.amount, specifier: "%.0f")")
                        Text("Category: \(expense.category?.name ?? "Unknown")")
                    }
                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
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
            return ChartSegmentData(category: category, percentage: percentage, color: .red) // Fixed red color
        }
    }
}
