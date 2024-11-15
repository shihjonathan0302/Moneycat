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
        case "Attractive":
            return "Criteria: High impact on satisfaction but not critical. Suggestion: These expenses enhance quality of life. Allocate budget wisely but avoid overindulgence."
        case "Must":
            return "Criteria: Essential and necessary for basic needs. Suggestion: Manage these expenses carefully as they are unavoidable but essential."
        case "One-Dimensional":
            return "Criteria: Provides direct, expected value without added delight. Suggestion: Focus on the value of these expenses, ensuring cost-effectiveness."
        case "Indifferent":
            return "Criteria: Low impact on satisfaction and can be reduced. Suggestion: Consider cutting down on these expenses, as they add minimal value to your lifestyle."
        default:
            return "No specific recommendation."
        }
    }
}
