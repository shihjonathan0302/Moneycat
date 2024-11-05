//
//  ContentView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var realmManager: RealmManager

    var body: some View {
        TabView {
            SocialView()
                .tabItem { Label("Social", systemImage: "person.bubble.fill") }
                .onAppear { print("Social View Loaded") }  // <--- Add this line

            ReportsView()
                .tabItem { Label("Reports", systemImage: "chart.xyaxis.line") }
                .onAppear { print("Reports View Loaded") }  // <--- Add this line

            AddExpenseView()
                .tabItem { Label("Add", systemImage: "plus.circle") }
                .onAppear { print("AddExpense View Loaded") }  // <--- Add this line

            ExpensesView()
                .tabItem { Label("Expenses", systemImage: "list.bullet") }
                .onAppear { print("Expenses View Loaded") }  // <--- Add this line

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .onAppear { print("Settings View Loaded") }  // <--- Add this line
        }
    }
}
