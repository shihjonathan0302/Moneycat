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
    @State private var sortOption: SortOption = .dateDescending // Default sorting option


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
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
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
                Text("No Expense")
                    .padding()
            }

            Divider()
                .padding(.vertical)
            
            Spacer().frame(height: 20) // Adjust this value as needed

            // Expenses List with Search Bar
            List {
                // Search Bar as First Item in the List
                HStack {
                    // Search Bar
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchQuery)
                            .foregroundColor(.primary)
                    }
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

                    Spacer() // Separate search bar and sort button visually

                    // Sort Button
                    Menu {
                        Button("Amount (Low to High)") { sortOption = .amountAscending }
                        Button("Amount (High to Low)") { sortOption = .amountDescending }
                        Button("Date (New to Old)") { sortOption = .dateDescending }
                        Button("Date (Old to New)") { sortOption = .dateAscending }
                        Button("Category (A-Z)") { sortOption = .categoryAscending }
                        Button("Category (Z-A)") { sortOption = .categoryDescending }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Filter")
                                .font(.footnote)
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
                        .cornerRadius(8)
                    }
                }

                // Filtered Expenses
                ForEach(filteredAndSortedExpenses()) { expense in
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
        .navigationTitle("Expense")
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
    
    private func filteredAndSortedExpenses() -> [Expense] {
            let validExpenses = realmManager.expenses.filter { !$0.isInvalidated }
            let filteredExpenses = validExpenses.filter { searchQuery.isEmpty || $0.note.localizedCaseInsensitiveContains(searchQuery) }
            print("Filtering \(filteredExpenses.count) expenses")

            switch sortOption {
            case .amountAscending:
                return filteredExpenses.sorted { $0.amount < $1.amount }
            case .amountDescending:
                return filteredExpenses.sorted { $0.amount > $1.amount }
            case .dateAscending:
                return filteredExpenses.sorted { $0.date < $1.date }
            case .dateDescending:
                return filteredExpenses.sorted { $0.date > $1.date }
            case .categoryAscending:
                return filteredExpenses.sorted { ($0.category?.name ?? "") < ($1.category?.name ?? "") }
            case .categoryDescending:
                return filteredExpenses.sorted { ($0.category?.name ?? "") > ($1.category?.name ?? "") }
            }
        }

    enum SortOption {
        case amountAscending, amountDescending, dateAscending, dateDescending, categoryAscending, categoryDescending
    }
}
