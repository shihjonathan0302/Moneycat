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
        VStack(alignment: .leading) {
            // Title at the top
            Text("Add New Category")
                .font(.largeTitle.bold())
                .padding([.top, .horizontal])  // Extra padding for the title

            // Main form in a list format
            List {
                Section {
                    // Color Picker section
                    VStack(alignment: .leading) {
                        Text("Select Color")
                            .font(.headline)
                        ColorPicker("Category Color", selection: $selectedColor)
                            .padding(.top, 8)  // Add top padding to give spacing
                    }
                    .padding(.vertical, 8)

                    // New Category Input with button inside a horizontal stack
                    HStack {
                        TextField("Enter New Category", text: $newCategoryName)
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)

                        Button(action: {
                            let newCategory = ExpenseCategory(name: newCategoryName, color: PersistableColor(color: selectedColor))
                            realmManager.submitCategory(newCategory)
                            newCategoryName = ""  // Reset the field
                        }) {
                            Text("Add")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
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
                                .fill(Color(persistableColor: category.color ?? PersistableColor(color: .blue)))  // Display category color
                                .frame(width: 20, height: 20)

                            Text(category.name)
                                .padding(.leading, 8)  // Add some space between circle and text
                        }
                        .padding(.vertical, 4)  // Add some vertical padding between each row
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())  // Make the list look grouped and modern

            Spacer()
        }
        .padding(.horizontal)  // Padding for the outermost view
    }
}
