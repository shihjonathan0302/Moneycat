//
//  ReportsView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI
import Charts
import RealmSwift

struct ReportsView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var showAnalyzeList = false
    @State private var dominantDimension: String? = nil // State to store dominant dimension

    var body: some View {
        NavigationStack {
            VStack {
                if !realmManager.expenses.isEmpty {
                    let expensesToAnalyze = realmManager.expenses.filter { $0.needOrWant == "Want" }

                    if !expensesToAnalyze.isEmpty {
                        ExpenseBetterWorseChart(expenses: expensesToAnalyze)
                            .frame(height: 300)
                            .padding()

                        Button(action: {
                            showAnalyzeList = true
                        }) {
                            Text("Analyze")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        // Calculate the dominant dimension once and store it
                        .onAppear {
                            dominantDimension = findDominantDimension(in: expensesToAnalyze)
                        }

                        // Display the recommendation box based on the calculated dominant dimension
                        if let dimension = dominantDimension {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Recommendation")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 20)

                                Text(recommendationText(for: dimension))
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                        } else {
                            Text("No dominant expense type identified.")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    } else {
                        Text("No 'Want' expenses to display.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                } else {
                    Text("No 'Want' expenses to display.")
                        .foregroundColor(.gray)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("Reports")
            .background(Color.white.ignoresSafeArea())
            .navigationDestination(isPresented: $showAnalyzeList) {
                AnalyzeExpenseListView()
            }
        }
    }

    // Helper function to find the dominant dimension
    // In ReportsView.swift
     func findDominantDimension(in expenses: [Expense]) -> String? {
        // Filter out expenses where dimension is still empty or "Unknown"
        let analyzedExpenses = expenses.filter { !$0.dimension.isEmpty }
        guard !analyzedExpenses.isEmpty else { return nil } // Return nil if no analyzed expenses

        let dimensionCounts = Dictionary(grouping: analyzedExpenses, by: { $0.dimension })
                              .mapValues { $0.count }
        return dimensionCounts.max { $0.value < $1.value }?.key
    }

    // Function to provide recommendation text based on dimension
    func recommendationText(for dimension: String) -> String {
        switch dimension {
        case "Basic Needs":
            return "These are essential expenses. Ensure they are managed within your budget."
        case "Performance Needs":
            return "Consider whether the expense offers value proportional to the benefit."
        case "Excitement Needs":
            return "Budget for these to avoid impulse purchases. Moderate as necessary."
        case "Indifferent Needs":
            return "Consider reducing these as they do not greatly impact your quality of life."
        default:
            return "No specific recommendation."
        }
    }
}

