//
//  SettingsView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var showAlert = false

    var body: some View {
        List {
            Section(header: Text("General Settings")) {
                NavigationLink(destination: AddCategoryView()) {
                    Text("Add Category")
                }
                NavigationLink(destination: LanguageSettingsView()) {
                    Text("Language Settings")
                }
                NavigationLink(destination: ThemeSettingsView()) {
                    Text("Theme Settings")
                }
                NavigationLink(destination: NotificationSettingsView()) {
                    Text("Notification Preferences")
                }
            }

            Section(header: Text("Accounts")) {
                NavigationLink(destination: UserProfileView()) {
                    Text("User Profile")
                }
                NavigationLink(destination: AccountManagementView()) {
                    Text("Account Management")
                }
            }

            Section(header: Text("App Preferences")) {
                NavigationLink(destination: FeedbackView()) {
                    Text("Send Feedback")
                }
                NavigationLink(destination: SupportView()) {
                    Text("Support")
                }
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text("Privacy Policy")
                }
            }

            Section(header: Text("Manage Data")) {
                Button(action: {
                    showAlert = true
                }) {
                    Text("Erase All Data").foregroundColor(.red)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Erase All Data"),
                        message: Text("Are you sure you want to remove all data? This action cannot be undone."),
                        primaryButton: .destructive(Text("Erase")),
                        secondaryButton: .cancel()
                    )
                }
            }

            Section(header: Text("About")) {
                NavigationLink(destination: AppInfoView()) {
                    Text("App Info")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
    }
}

// Views for different settings options
struct UserProfileView: View {
    var body: some View {
        Text("User Profile Settings")
    }
}

struct AccountManagementView: View {
    var body: some View {
        Text("Manage Account")
    }
}

struct ThemeSettingsView: View {
    var body: some View {
        Text("Theme Settings")
    }
}

struct FeedbackView: View {
    var body: some View {
        Text("Feedback Form")
    }
}

struct SupportView: View {
    var body: some View {
        Text("Support Information")
    }
}
