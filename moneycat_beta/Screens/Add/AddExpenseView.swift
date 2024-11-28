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
    @State private var expenseAmount: String = ""
    @State private var selectedCategory: ExpenseCategory? = nil
    @State private var date = Date()
    @State private var needOrWant = "Need"
    @State private var isShowingCategoryPicker = false

    @State private var showErrorMessage: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Amount Field
                HStack(spacing: 12) {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Amount")
                            .font(.headline)
                        TextField("Enter amount", text: $expenseAmount)
                            .keyboardType(.decimalPad) // Ensures number pad appears
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !expenseAmount.isEmpty {
                                        Button(action: { expenseAmount = "" }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 8)
                                    }
                                }
                            )
                    }
                }
                .padding(.vertical, 8)

                // Category Picker
                HStack(spacing: 12) {
                    Image(systemName: "tag.fill")
                        .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
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
                        .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
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
                        .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
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
                        .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
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
                        showErrorMessage = "Please enter a valid amount greater than 0."
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
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 140)
                        .background(Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 1))
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

