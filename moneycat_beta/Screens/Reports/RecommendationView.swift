//
//  RecommendationView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/11/9.
//

import SwiftUI

struct RecommendationView: View {
    var dimension: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recommendation")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 20)

            if !dimension.isEmpty {
                Text(recommendationText(for: dimension))
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
            } else {
                Text("No dimension available for recommendation.")
                    .font(.body)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
    }

    // Provide recommendation text based on dimension
    private func recommendationText(for dimension: String) -> String {
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
