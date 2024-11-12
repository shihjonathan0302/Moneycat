//
//  ContentView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var selectedTab = 1  // Default to the first tab, change this based on your default view

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ReportsView()
            }
            .tabItem { Label("Reports", systemImage: "chart.xyaxis.line") }
            .tag(1)
            .onAppear { print("Reports View Loaded") }

            NavigationStack {
                AddExpenseView()
            }
            .tabItem { Label("Add", systemImage: "plus.circle") }
            .tag(2)
            .onAppear { print("AddExpense View Loaded") }

            NavigationStack {
                ExpensesView()
            }
            .tabItem { Label("Expenses", systemImage: "list.bullet") }
            .tag(3)
            .onAppear { print("Expenses View Loaded") }

            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
            .tag(4)
            .onAppear {
                print("Settings View Loaded")
            }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.systemBackground  // Optional: change the tab bar appearance
        }
    }
}
