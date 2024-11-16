//
//  AddCategoryView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct AddCategoryView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var newCategoryName: String = ""
    @State private var selectedColor: Color = .blue  // Default color

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Main form
            List {
                Section {
                    // Color Picker section
                    VStack(alignment: .leading) {
                        ColorPicker("Select Color", selection: $selectedColor)
                            .padding(.top, 8)
                    }
                    .padding(.vertical, 8)

                    // New Category Input with button
                    HStack(spacing: 8) {
                        TextField("Enter New Category", text: $newCategoryName)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(height: 44) // Match height with button
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )

                        Button(action: {
                            guard !newCategoryName.isEmpty else { return }
                            let newCategory = ExpenseCategory(name: newCategoryName, color: PersistableColor(color: selectedColor))
                            realmManager.submitCategory(newCategory)
                            newCategoryName = ""  // Reset the field
                        }) {
                            Text("Add")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 44) // Fixed width and height
                                .background(Color.orange)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.vertical, 8)
                }

                // Section for displaying the current categories with their colors
                Section(header: Text("Current Categories")) {
                    ForEach(realmManager.categories, id: \.id) { category in
                        HStack {
                            Circle()
                                .fill(Color(persistableColor: category.color ?? PersistableColor(color: .blue)))
                                .frame(width: 20, height: 20)

                            Text(category.name)
                                .padding(.leading, 8)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Add Category")
            .listStyle(InsetGroupedListStyle()) // Grouped style for a modern look
            .background(Color(.systemGray6))    // Gray background for the entire list
            .cornerRadius(10)                  // Corner radius for the list container
            .padding(.top, -15)                // Reduce spacing under the navigation bar
        }
        .padding()
        .background(Color(.systemGray6).ignoresSafeArea()) // Full gray background
    }
}
