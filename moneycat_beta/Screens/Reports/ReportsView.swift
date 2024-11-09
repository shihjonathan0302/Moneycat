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
    func findDominantDimension(in expenses: [Expense]) -> String? {
        let dimensionCounts = Dictionary(grouping: expenses, by: { $0.dimension }).mapValues { $0.count }
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

struct ExpenseBetterWorseChart: View {
    var expenses: [Expense]

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("Attractive")
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.leading, 5)
                    Spacer()
                    Text("Indifferent")
                        .foregroundColor(.blue)
                        .font(.caption)
                        .padding(.trailing, 5)
                }
                Spacer()
                HStack {
                    Text("Must")
                        .foregroundColor(.yellow)
                        .font(.caption)
                        .padding(.leading, 5)
                    Spacer()
                    Text("One-Dimensional")
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.trailing, 5)
                }
            }
            .zIndex(1)

            Chart {
                RectangleMark(xStart: .value("Left", -100), xEnd: .value("Right", -50),
                              yStart: .value("Bottom", 0), yEnd: .value("Top", 50))
                    .foregroundStyle(Color.yellow.opacity(0.15))

                RectangleMark(xStart: .value("Left", -50), xEnd: .value("Right", 0),
                              yStart: .value("Bottom", 0), yEnd: .value("Top", 50))
                    .foregroundStyle(Color.red.opacity(0.15))

                RectangleMark(xStart: .value("Left", -100), xEnd: .value("Right", -50),
                              yStart: .value("Bottom", 50), yEnd: .value("Top", 100))
                    .foregroundStyle(Color.green.opacity(0.15))

                RectangleMark(xStart: .value("Left", -50), xEnd: .value("Right", 0),
                              yStart: .value("Bottom", 50), yEnd: .value("Top", 100))
                    .foregroundStyle(Color.blue.opacity(0.15))

                ForEach(expenses, id: \.id) { expense in
                    let better = expense.betterCoefficient
                    let worse = expense.worseCoefficient
                    let categoryColor = expense.category?.color?.toUIColor() ?? UIColor.gray

                    PointMark(
                        x: .value("Worse", worse),
                        y: .value("Better", better)
                    )
                    .foregroundStyle(Color(uiColor: categoryColor))
                    .symbolSize(100)
                }

                RuleMark(y: .value("50% Better", 50))
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundStyle(.gray.opacity(0.5))

                RuleMark(x: .value("50% Worse", -50))
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundStyle(.gray.opacity(0.5))
            }
            .padding()
            .chartXScale(domain: -100...0)
            .chartYScale(domain: 0...100)
        }
    }
}
