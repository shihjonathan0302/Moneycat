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
    @State private var searchQuery: String = ""
    
    @State private var isBarChart = true // State for chart type toggle

    var body: some View {
        VStack {
            // Summary Section
            let summary = calculateSummary(for: selectedTimeRange)
            // Display the summary section
            SummarySection(total: summary.total, topCategory: summary.topCategory, color: summary.color)
                .padding(.bottom, 5) // Add spacing below the summary section
            
            // Time Range Picker and Toggle
            HStack {
                Picker("Time Range", selection: $selectedTimeRange) {
                    ForEach(TimeRange.allCases, id: \.self) { range in
                        Text(range.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                // Toggle Button
                Button(action: {
                    isBarChart.toggle()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: isBarChart ? "chart.bar.fill" : "chart.pie.fill")
                        Text(isBarChart ? "Bar" : "Pie")
                    }
                    .font(.footnote)
                    .padding(8)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                }
            }
            .padding([.horizontal, .top])

            // Chart
            if let chartData = generateChartData(for: selectedTimeRange) {
                if isBarChart {
                    VerticalBarChartView(data: chartData)
                        .frame(height: 250)
                        .padding(.horizontal)
                } else {
                    PieChartView(data: chartData)
                        .frame(height: 250)
                        .padding(.horizontal)
                }
            } else {
                Text("No expenses to display. Please add some expenses.")
                    .padding()
            }

            Divider()
                .padding(.vertical)
            
            Spacer().frame(height: 20) // Adjust this value as needed

            // Expenses List with Search Bar
            List {
                // Search Bar as First Item in the List
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search by note", text: $searchQuery)
                        .foregroundColor(.primary)
                }
                .padding(10) // Padding for content inside the gray bar
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)) // Inset within the list
                .listRowBackground(Color.white) // Ensure it matches the list's background

                // Filtered Expenses
                ForEach(filteredExpenses()) { expense in
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
                            realmManager.deleteExpense(expense)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemGray6))
        .navigationTitle("Expenses")
        .onReceive(realmManager.$updateTrigger) { _ in
            // Automatically refresh UI when expenses are updated
            print("Debug: updateTrigger fired, refreshing ExpensesView")
        }
    }

    // Filter expenses based on the search query
    private func filteredExpenses() -> [Expense] {
        let validExpenses = realmManager.expenses.filter { !$0.isInvalidated }
        return validExpenses.filter { expense in
            searchQuery.isEmpty || expense.note.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    func generateChartData(for timeRange: TimeRange) -> [ChartSegmentData]? {
        let filteredExpenses = realmManager.expenses
            .filter { !$0.isInvalidated && Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: timeRange.calendarComponent) }

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
