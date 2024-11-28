//
//  ContentView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var selectedTab = 1  // Default to the first tab

    init() {
        // Customize the tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground

        // Set colors for the tab bar items
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemOrange
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]

        // Apply the appearance to both the standard and scroll edge appearances
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ReportsView()
            }
            .tabItem { Label("Reports", systemImage: "chart.xyaxis.line") }
            .tag(1)

            NavigationStack {
                AddExpenseView()
            }
            .tabItem { Label("Add", systemImage: "plus.circle") }
            .tag(2)

            NavigationStack {
                ExpensesView()
            }
            .tabItem { Label("Expenses", systemImage: "list.bullet") }
            .tag(3)

            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
            .tag(4)
        }
        .onAppear {
            print("Debug: ContentView appeared, selectedTab: \(selectedTab)")
        }
    }
}
