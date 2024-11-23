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
    
    //    @State private var isExpenseInvalid = false // New state for invalidated expense check
    
    var body: some View {
        NavigationStack {
            VStack {
                // Safely filter out invalidated expenses
                let validExpenses = realmManager.expenses.filter { !$0.isInvalidated }
                if !validExpenses.isEmpty {
                    let expensesToAnalyze = validExpenses.filter { $0.needOrWant == "Want" && !$0.dimension.isEmpty }
                    
                    if !expensesToAnalyze.isEmpty {
                        ExpenseBetterWorseChart(realmManager: realmManager)
                            .frame(height: 300)
                            .padding()
                        
                        HStack(spacing: 16) { // Add spacing between buttons
                            Button(action: {
                                print("Debug: Refresh button clicked")
                                realmManager.refreshExpenses() // Explicitly reload all expenses
                                let refreshedExpenses = realmManager.expenses.filter { !$0.isInvalidated && $0.needOrWant == "Want" }
                                print("Debug: Refreshed expenses:")
                                refreshedExpenses.forEach { expense in
                                    print("Expense: \(expense.note), Better: \(expense.betterCoefficient), Worse: \(expense.worseCoefficient)")
                                }
                            }) {
                                Button(action: {
                                    showAnalyzeList = true
                                }) {
                                    Text("Analyze")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.orange)
                                        .cornerRadius(8)
                                }
                                
                                HStack {
                                    Image(systemName: "arrow.clockwise")
                                        .foregroundColor(.orange)
                                    Text("Refresh")
                                        .foregroundColor(.orange)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 16) // Add horizontal padding for alignment with the chart
                        
                        .padding()
                        .onAppear {
                            print("Debug: ReportsView appeared")
                            updateDominantDimension(expensesToAnalyze)
                        }
                        
                        // Trigger data refresh on delete or updates
                        .onReceive(realmManager.$updateTrigger) { _ in
                            print("Debug: updateTrigger fired, refreshing chart and dimension")
                            updateDominantDimension(realmManager.expenses.filter { !$0.isInvalidated && $0.needOrWant == "Want" })
                        }
                        
                        if let dimension = dominantDimension {
                            RecommendationView(dimension: dimension)
                                .padding(.horizontal, 16)
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
                    Text("No expenses available.")
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
            .onReceive(realmManager.$updateTrigger) { _ in
                let validExpenses = realmManager.expenses.filter { !$0.isInvalidated && $0.needOrWant == "Want" && !$0.dimension.isEmpty }
                print("Debug: Refreshing chart. Valid expenses for chart:")
                validExpenses.forEach { expense in
                    print("Expense: \(expense.note), Better: \(expense.betterCoefficient), Worse: \(expense.worseCoefficient)")
                }
                updateDominantDimension(validExpenses)
            }
        }
    }
    
    func updateDominantDimension(_ expenses: [Expense]) {
        print("Debug: Updating dominant dimension")
        dominantDimension = findDominantDimension(in: expenses)
    }
    
    func findDominantDimension(in expenses: [Expense]) -> String? {
        let analyzedExpenses = expenses.filter { !$0.isInvalidated && !$0.dimension.isEmpty }
        guard !analyzedExpenses.isEmpty else {
            print("Debug: No analyzed expenses found")
            return nil
        }
        
        let dimensionCounts = Dictionary(grouping: analyzedExpenses, by: { $0.dimension })
            .mapValues { $0.count }
        return dimensionCounts.max { $0.value < $1.value }?.key
    }
}
