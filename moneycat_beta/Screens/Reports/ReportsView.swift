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
    @State private var resetToRoot = false
    @State private var dominantDimension: String? = nil

    var body: some View {
        NavigationStack {
            VStack {
                // Filter out invalidated expenses before displaying
                let validExpenses = realmManager.expenses.filter { !$0.isInvalidated }
                if !validExpenses.isEmpty {
                    let expensesToAnalyze = validExpenses.filter { $0.needOrWant == "Want" }
                    
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
                        
                        .onAppear {
                            dominantDimension = findDominantDimension(in: expensesToAnalyze)
                        }

                        // Trigger data refresh on delete
                        .onReceive(realmManager.$updateTrigger) { _ in
                            dominantDimension = findDominantDimension(in: expensesToAnalyze)
                        }

                        if let dimension = dominantDimension {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Recommendation")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .padding(.top, 20)
                                    .padding(.leading, 16)

                                Text(recommendationDetail(for: dimension))
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 16)
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
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationDestination(isPresented: $showAnalyzeList) {
                AnalyzeExpenseListView(resetToRoot: $resetToRoot)
            }
            .onChange(of: resetToRoot) {
                if resetToRoot {
                    showAnalyzeList = false
                    resetToRoot = false
                }
            }
       }
    }

    func findDominantDimension(in expenses: [Expense]) -> String? {
        let analyzedExpenses = expenses.filter { !$0.isInvalidated && !$0.dimension.isEmpty }
        guard !analyzedExpenses.isEmpty else { return nil }

        let dimensionCounts = Dictionary(grouping: analyzedExpenses, by: { $0.dimension })
                              .mapValues { $0.count }
        return dimensionCounts.max { $0.value < $1.value }?.key
    }

    func recommendationDetail(for dimension: String) -> String {
        switch dimension {
        case "Attractive":
            return """
            Criteria: High impact on satisfaction but not critical.
            Suggestion: These expenses enhance quality of life. Allocate budget wisely but avoid overindulgence.
            """
        case "Must":
            return """
            Criteria: Essential and necessary for basic needs.
            Suggestion: Manage these expenses carefully as they are unavoidable but essential.
            """
        case "One-Dimensional":
            return """
            Criteria: Provides direct, expected value without added delight.
            Suggestion: Focus on the value of these expenses, ensuring cost-effectiveness.
            """
        case "Indifferent":
            return """
            Criteria: Low impact on satisfaction and can be reduced.
            Suggestion: Consider cutting down on these expenses, as they add minimal value to your lifestyle.
            """
        default:
            return "No specific recommendation."
        }
    }
}
