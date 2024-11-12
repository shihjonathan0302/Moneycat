//
//  AddExpenseView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI
import RealmSwift

struct AddExpenseView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var expenseNote: String = ""
    @State private var expenseAmount: String = ""  // Changed to string to display placeholder text
    @State private var selectedCategory: ExpenseCategory? = nil
    @State private var date = Date()
    @State private var needOrWant = "Need"  // Default selection

    var body: some View {
        VStack {
//            // Change "Add" to match "Settings" style
//            Text("Add")
//                .font(.system(size: 24, weight: .semibold, design: .rounded))  // Matched to Settings style
//                .foregroundColor(.primary)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding([.leading, .top])

            // Updated form with flat design
            VStack(spacing: 20) {
                // Amount field with minimalistic flat design
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amount")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("Enter amount", text: $expenseAmount)
                        .keyboardType(.decimalPad)
                        .padding(12)
                        .background(Color(.systemGray6))  // Flat background color
                        .cornerRadius(10)  // Subtle corner radius
                }

                // Category Picker with left-aligned label
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.headline)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Choose Category")  // Left-aligned text label
                            .foregroundColor(.gray)
                        Spacer()
                        Picker("", selection: $selectedCategory) {
                            ForEach(realmManager.categories, id: \.id) { category in
                                Text(category.name).tag(category as ExpenseCategory?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(Color(.systemGray6))  // Flat background color
                        .cornerRadius(10)  // Subtle corner radius
                    }
                    .padding(.vertical, 8)
                }

                // Date Picker with a flat look
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.headline)
                        .foregroundColor(.gray)
                    DatePicker("Select Date", selection: $date, displayedComponents: [.date])
                        .padding(12)
                        .background(Color(.systemGray6))  // Flat background
                        .cornerRadius(10)
                }

                // Note field with consistent flat design
                VStack(alignment: .leading, spacing: 8) {
                    Text("Note")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("Enter note", text: $expenseNote)
                        .padding(12)
                        .background(Color(.systemGray6))  // Flat background
                        .cornerRadius(10)
                }

                // Need or Want toggle, removing extra frame
                VStack(alignment: .leading, spacing: 8) {
                    Text("Need or Want")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Picker("", selection: $needOrWant) {
                        Text("Need").tag("Need")
                        Text("Want").tag("Want")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.clear)  // No background
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)  // Removed shadow for flat design

            // Add Expense button with reduced width and flat look
            Button(action: {
                let newExpense = Expense()
                newExpense.note = expenseNote
                newExpense.amount = Double(expenseAmount) ?? 0.0
                newExpense.category = selectedCategory
                newExpense.date = date
                newExpense.needOrWant = needOrWant
                newExpense.dimension = ""  // Initialize dimension as empty


                realmManager.submitExpense(newExpense)
                expenseNote = ""
                expenseAmount = ""
                needOrWant = "Need"
            }) {
                Text("Add Expense")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 44)  // Reduced width for smaller button
                    .background(Color.blue)
                    .cornerRadius(10)  // Smaller corner radius for flatter style
            }
            .padding(.top, 16)

            Spacer()
        }
        .navigationTitle("Add")
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))  // Flat background color
    }
}
