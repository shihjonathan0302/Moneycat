//
//  AnalyzeView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/13.
//

import SwiftUI
import RealmSwift

struct AnalyzeView: View {
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.presentationMode) var presentationMode
    @State var expense: Expense
    @Binding var resetToRoot: Bool

    @State private var q1 = 3
    @State private var q2 = 3
    @State private var q3 = 3
    @State private var q4 = 3
    @State private var q5 = 3
    @State private var q6 = 3
    @State private var q7 = 3
    @State private var q8 = 3

    @State private var isExpenseInvalid = false // New state for invalidated expense check

    var body: some View {
        VStack {
            if isExpenseInvalid {
                // Display an error message if the expense is invalidated
                Text("This expense is no longer valid.")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
            } else {
                List {
                    Section(header: Text("Must-Be")) {
                        QuestionView(
                            questionText: "1. After purchasing this item, are you satisfied with it?",
                            labels: ["Very Unsatisfied", "Unsatisfied", "Neutral", "Satisfied", "Very Satisfied"],
                            rating: $q1
                        )
                        QuestionView(
                            questionText: "2. If you did not purchase this item, would you feel dissatisfied?",
                            labels: ["Not at all", "Slightly", "Neutral", "Fairly", "Very Dissatisfied"],
                            rating: $q2
                        )
                    }

                    Section(header: Text("Attractive")) {
                        QuestionView(
                            questionText: "3. After purchasing this item, do you feel happy or fulfilled?",
                            labels: ["Not at all", "Slightly", "Neutral", "Fairly", "Very Fulfilled"],
                            rating: $q3
                        )
                        QuestionView(
                            questionText: "4. If you did not purchase this item, would you feel sad or regretful?",
                            labels: ["Not at all", "Slightly", "Neutral", "Fairly", "Very Sad"],
                            rating: $q4
                        )
                    }

                    Section(header: Text("Performance")) {
                        QuestionView(
                            questionText: "5. Does this item meet the value you expected it to have?",
                            labels: ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"],
                            rating: $q5
                        )
                        QuestionView(
                            questionText: "6. If this item does not exceed your expectations, does it affect your satisfaction?",
                            labels: ["Not at all", "Slightly", "Neutral", "Fairly", "Very Much"],
                            rating: $q6
                        )
                    }

                    Section(header: Text("Indifferent")) {
                        QuestionView(
                            questionText: "7. After purchasing this item, has it impacted your life?",
                            labels: ["Not at all", "Slightly", "Neutral", "Fairly", "Very Much"],
                            rating: $q7
                        )
                        QuestionView(
                            questionText: "8. If you did not purchase this item, would your life be affected?",
                            labels: ["Not at all", "Slightly", "Neutral", "Fairly", "Very Much"],
                            rating: $q8
                        )
                    }


                    Section {
                        Button(action: {
                            if expense.isInvalidated {
                                print("Error: Attempted to analyze an invalidated expense.")
                                isExpenseInvalid = true
                                return
                            }

                            let expectationScore = Double(q3 + q4) / 2.0
                            let attractionScore = Double(q5 + q6) / 2.0
                            let mustHaveScore = Double(q1 + q2) / 2.0

                            let betterCoefficient = (expectationScore + attractionScore) / (expectationScore + attractionScore + mustHaveScore)
                            let worseCoefficient = (-1) * (expectationScore + mustHaveScore) / (expectationScore + attractionScore + mustHaveScore)

                            let calculatedDimension = determineDimension(
                                betterCoefficient: betterCoefficient * 100,
                                worseCoefficient: worseCoefficient * 100
                            )

                            realmManager.updateExpense(
                                expense: expense,
                                better: betterCoefficient * 100,
                                worse: worseCoefficient * 100,
                                dimension: calculatedDimension
                            )

                            print("Debug: Submitted expense: \(expense.note)")
                            print("Debug: Better Coefficient: \(betterCoefficient * 100)")
                            print("Debug: Worse Coefficient: \(worseCoefficient * 100)")
                            print("Debug: Dimension: \(calculatedDimension)")
                            
                            // Notify other views to refresh without directly refreshing expenses
                            realmManager.updateTrigger.toggle()
                            resetToRoot = true
                        }) {
                            Text("Submit")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
                                .cornerRadius(8)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.horizontal, -10)
                .background(Color(.systemGray6))
                .padding(.horizontal)
            }
        }
        .navigationTitle("Analyze")
        .background(Color(.systemGray6).ignoresSafeArea())
        .onAppear {
            isExpenseInvalid = expense.isInvalidated
        }
    }

    func determineDimension(betterCoefficient: Double, worseCoefficient: Double) -> String {
        if betterCoefficient > 50 && worseCoefficient < -50 {
            return "Attractive"
        } else if betterCoefficient > 50 {
            return "One-Dimensional"
        } else if worseCoefficient < -50 {
            return "Must"
        } else {
            return "Indifferent"
        }
    }
}

struct QuestionView: View {
    var questionText: String
    var labels: [String] // Text labels for the slider
    @Binding var rating: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(questionText)
                .font(.body)
                .padding(.bottom, 5)

            // Slider with labels
            VStack {
                Slider(value: Binding(
                    get: { Double(rating - 1) }, // Convert 1-5 to 0-4 for slider
                    set: { rating = Int($0) + 1 } // Convert back to 1-5
                ), in: 0...4, step: 1)
                    .accentColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))

                // Dynamic text labels below the slider
                HStack {
                    ForEach(labels.indices, id: \.self) { index in
                        Text(labels[index])
                            .font(.caption)
                            .frame(maxWidth: .infinity) // Evenly space labels
                            .foregroundColor(index == rating - 1 ? Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1) : .gray)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
