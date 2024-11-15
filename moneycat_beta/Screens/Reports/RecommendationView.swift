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
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Recommendation")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                    .padding(.horizontal)

                if !dimension.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        // Criteria Section
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.yellow)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Criteria")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.primary)
                                Text(getCriteria(for: dimension))
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        // Suggestion Section
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.blue)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Suggestion")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.primary)
                                Text(getSuggestion(for: dimension))
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Subtle shadow for elevation
                    .padding(.horizontal)
                    .padding(.bottom, 20) // Additional space above the tab bar
                } else {
                    Text("No dimension available for recommendation.")
                        .font(.body)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
        }
    }

    private func getCriteria(for dimension: String) -> String {
        switch dimension {
        case "Attractive":
            return "High impact on satisfaction but not critical."
        case "Must":
            return "Essential and necessary for basic needs."
        case "One-Dimensional":
            return "Provides direct, expected value without added delight."
        case "Indifferent":
            return "Low impact on satisfaction and can be reduced."
        default:
            return "No specific criteria available."
        }
    }

    private func getSuggestion(for dimension: String) -> String {
        switch dimension {
        case "Attractive":
            return "These expenses enhance quality of life. Allocate budget wisely but avoid overindulgence."
        case "Must":
            return "Manage these expenses carefully as they are unavoidable but essential."
        case "One-Dimensional":
            return "Focus on the value of these expenses, ensuring cost-effectiveness."
        case "Indifferent":
            return "Consider cutting down on these expenses, as they add minimal value to your lifestyle."
        default:
            return "No specific suggestion available."
        }
    }
}
