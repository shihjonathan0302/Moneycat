//
//  SummarySection.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/11/27.
//

import SwiftUI

struct SummarySection: View {
    var total: Double
    var topCategory: String
    var color: Color

    var body: some View {
        HStack {
            // Left side: Total
            VStack(alignment: .leading, spacing: 4) {
                Text("Total")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(Int(total))") // Rounded to an integer
                    .font(.headline)
                    .bold()
                    .foregroundColor(.orange)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Ensure it takes half the width

            // Divider
            Divider()
                .frame(height: 40) // Adjust divider height
                .background(Color.gray.opacity(0.5)) // Lighter divider color

            // Right side: Top Category
            VStack(alignment: .leading, spacing: 4) {
                Text("Top Category")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(topCategory)
                    .font(.headline)
                    .bold()
                    .foregroundColor(color)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Ensure it takes half the width
        }
        .padding(8) // Padding inside the section
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 16) // Horizontal padding for alignment
    }
}

extension ExpensesView {
    func calculateSummary(for timeRange: TimeRange) -> (total: Double, topCategory: String, color: Color) {
        let filteredExpenses = realmManager.expenses
            .filter { !$0.isInvalidated && Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: timeRange.calendarComponent) }

        guard !filteredExpenses.isEmpty else {
            return (total: 0.0, topCategory: "N/A", color: .gray)
        }

        let total = filteredExpenses.reduce(0) { $0 + $1.amount }

        let groupedByCategory = Dictionary(grouping: filteredExpenses, by: { $0.category?.name ?? "Unknown" })
        let topCategory = groupedByCategory.max { $0.value.reduce(0) { $0 + $1.amount } < $1.value.reduce(0) { $0 + $1.amount } }

        let topCategoryName = topCategory?.key ?? "N/A"
        let topCategoryColor = topCategory?.value.first?.category?.color?.toUIColor() ?? UIColor.gray

        return (total: total, topCategory: topCategoryName, color: Color(uiColor: topCategoryColor))
    }
}
