//
//  CategoryPickerView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/11/26.
//

import SwiftUI
import RealmSwift

struct CategoryPickerView: View {
    @EnvironmentObject var realmManager: RealmManager
    @Binding var selectedCategory: ExpenseCategory?
    @Environment(\.presentationMode) var presentationMode  // Environment variable to dismiss the view
    
    var body: some View {
        NavigationView {
            List {
                ForEach(realmManager.categories, id: \.id) { category in
                    Button(action: {
                        selectedCategory = category
                        presentationMode.wrappedValue.dismiss()  // Dismisses the view when a category is selected
                    }) {
                        HStack {
                            Circle()
                                .fill(Color(uiColor: category.color?.toUIColor() ?? .gray))
                                .frame(width: 20, height: 20)
                            Text(category.name)
                                .foregroundColor(.black)
                                .padding(.leading, 8)
                            Spacer()
                            if selectedCategory == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .foregroundColor(.black)
            .navigationTitle("Select Category")
        }
    }
}

