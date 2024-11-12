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
            // SocialView might be commented out or not needed based on your current design
            // SocialView()
            //     .tabItem { Label("Social", systemImage: "person.bubble.fill") }
            //     .tag(0)
            //     .onAppear { print("Social View Loaded") }

            ReportsView()
                .tabItem { Label("Reports", systemImage: "chart.xyaxis.line") }
                .tag(1)  // Each tag must be unique
                .onAppear { print("Reports View Loaded") }

            AddExpenseView()
                .tabItem { Label("Add", systemImage: "plus.circle") }
                .tag(2)  // Change tags as needed
                .onAppear { print("AddExpense View Loaded") }

            ExpensesView()
                .tabItem { Label("Expenses", systemImage: "list.bullet") }
                .tag(3)
                .onAppear { print("Expenses View Loaded") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(4)
                .onAppear {
                    print("Settings View Loaded")
                    // Add any additional setup if needed when Settings is focused
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.systemBackground  // Optional: change the tab bar appearance
        }
    }
}
