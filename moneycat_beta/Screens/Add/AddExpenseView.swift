//
//  AddExpenseView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

//
//  AddExpenseView.swift
//  moneycat_beta
//

import SwiftUI
import RealmSwift

struct AddExpenseView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var expenseNote: String = ""
    @State private var expenseAmount: String = ""
    @State private var selectedCategory: ExpenseCategory? = nil
    @State private var date = Date()
    @State private var needOrWant = "Need"
    @State private var isShowingCategoryPicker = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Amount Field
                HStack(spacing: 12) {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(.orange)
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Amount")
                            .font(.headline)
                        TextField("Enter amount", text: $expenseAmount)
                            .keyboardType(.decimalPad) // Ensures number pad appears
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical, 8)

                // Category Picker
                HStack(spacing: 12) {
                    Image(systemName: "tag.fill")
                        .foregroundColor(.orange)
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Category")
                            .font(.headline)
                        Button(action: {
                            isShowingCategoryPicker = true
                        }) {
                            HStack {
                                Text(selectedCategory?.name ?? "Choose Category")
                                    .foregroundColor(.gray)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                        .sheet(isPresented: $isShowingCategoryPicker) {
                            CategoryPickerView(selectedCategory: $selectedCategory)
                        }
                    }
                }
                .padding(.vertical, 8)

                // Date Picker
                HStack(spacing: 12) {
                    Image(systemName: "calendar")
                        .foregroundColor(.orange)
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Date").font(.headline)
                        HStack {
                            Text("Select Date")
                                .foregroundColor(.gray)
                            Spacer()
                            DatePicker("", selection: $date, displayedComponents: [.date])
                                .labelsHidden()
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                .padding(.vertical, 8)

                // Note Field
                HStack(spacing: 12) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.orange)
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Note")
                            .font(.headline)
                        TextField("Enter note", text: $expenseNote)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical, 8)

                // Need or Want Picker
                HStack(spacing: 12) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.orange)
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Need or Want")
                            .font(.headline)
                        Picker("", selection: $needOrWant) {
                            Text("Need").tag("Need")
                            Text("Want").tag("Want")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .padding(.vertical, 8)

                // Submit Button
                Button(action: {
                    guard let amount = Double(expenseAmount), amount > 0 else {
                        print("Invalid amount")
                        return
                    }

                    let newExpense = Expense()
                    newExpense.note = expenseNote
                    newExpense.amount = amount
                    newExpense.category = selectedCategory
                    newExpense.date = date
                    newExpense.needOrWant = needOrWant
                    realmManager.submitExpense(newExpense)

                    // Reset fields
                    expenseNote = ""
                    expenseAmount = ""
                    selectedCategory = nil
                    needOrWant = "Need"
                }) {
                    Text("Add Expense")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 140)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .padding(.top, 16)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .navigationTitle("Add")
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

// Custom category picker as a sheet
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
                        }
                    }
                }
            }
            .foregroundColor(.black)
            .navigationTitle("Select Category")
        }
    }
}
