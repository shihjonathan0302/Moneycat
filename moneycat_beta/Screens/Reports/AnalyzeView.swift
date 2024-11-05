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
    @State var expense: Expense

    // Rating variables for each question
    @State private var q1 = 3
    @State private var q2 = 3
    @State private var q3 = 3
    @State private var q4 = 3
    @State private var q5 = 3
    @State private var q6 = 3
    @State private var q7 = 3
    @State private var q8 = 3

    var body: some View {
        VStack {
            // Updated title
            Text("Analyze")
                .font(.title2)
                .padding(.top)

            List {
                // For each question, provide segmented picker options
                Group {
                    QuestionView(questionText: "1. After purchasing this item, are you satisfied with it?", rating: $q1)
                    QuestionView(questionText: "2. If you did not purchase this item, would you feel dissatisfied?", rating: $q2)
                    QuestionView(questionText: "3. After purchasing this item, do you feel happy or fulfilled?", rating: $q3)
                    QuestionView(questionText: "4. If you did not purchase this item, would you feel sad or regretful?", rating: $q4)
                    QuestionView(questionText: "5. Does this item meet the value you expected it to have?", rating: $q5)
                    QuestionView(questionText: "6. If this item does not exceed your expectations, does it affect your satisfaction?", rating: $q6)
                    QuestionView(questionText: "7. After purchasing this item, has it impacted your life?", rating: $q7)
                    QuestionView(questionText: "8. If you did not purchase this item, would your life be affected?", rating: $q8)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.horizontal)

            Button(action: {
                // Updated calculation for better and worse coefficients
                let expectationScore = Double(q3 + q4) / 2.0
                let attractionScore = Double(q5 + q6) / 2.0
                let mustHaveScore = Double(q1 + q2) / 2.0

                // Calculate Better and Worse Coefficients
                let betterCoefficient = (expectationScore + attractionScore) / (expectationScore + attractionScore + mustHaveScore)
                let worseCoefficient = (-1) * (expectationScore + mustHaveScore) / (expectationScore + attractionScore + mustHaveScore)

                // Update expense in Realm and reload
                realmManager.updateExpense(expense: expense, better: betterCoefficient * 100, worse: worseCoefficient * 100)
                realmManager.loadExpenses()
            }) {
                Text("Submit Analysis")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Analyze")
    }
}

struct QuestionView: View {
    var questionText: String
    @Binding var rating: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(questionText)
                .font(.body)
                .padding(.bottom, 5)

            Picker("", selection: $rating) {
                ForEach(1..<6) { i in
                    Text("\(i)").tag(i)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.vertical, 8)  // Add vertical spacing between questions
    }
}
