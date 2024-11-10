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

                                Text(recommendationDetail(for: dimension))
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
    func findDominantDimension(in expenses: [Expense]) -> String? {
        // Filter out expenses where dimension is still empty or "Unknown"
        let analyzedExpenses = expenses.filter { !$0.dimension.isEmpty }
        guard !analyzedExpenses.isEmpty else { return nil } // Return nil if no analyzed expenses

        let dimensionCounts = Dictionary(grouping: analyzedExpenses, by: { $0.dimension })
                              .mapValues { $0.count }
        return dimensionCounts.max { $0.value < $1.value }?.key
    }

    // Function to provide recommendation details (criteria and suggestion) based on dimension
    func recommendationDetail(for dimension: String) -> String {
        switch dimension {
        case "Attractive":
            return """
            **Criteria**: High impact on satisfaction but not critical.
            **Suggestion**: These expenses enhance quality of life. Allocate budget wisely but avoid overindulgence.
            """
        case "Must":
            return """
            **Criteria**: Essential and necessary for basic needs.
            **Suggestion**: Manage these expenses carefully as they are unavoidable but essential.
            """
        case "One-Dimensional":
            return """
            **Criteria**: Provides direct, expected value without added delight.
            **Suggestion**: Focus on the value of these expenses, ensuring cost-effectiveness.
            """
        case "Indifferent":
            return """
            **Criteria**: Low impact on satisfaction and can be reduced.
            **Suggestion**: Consider cutting down on these expenses, as they add minimal value to your lifestyle.
            """
        default:
            return "No specific recommendation."
        }
    }
}
