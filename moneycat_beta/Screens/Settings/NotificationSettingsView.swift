//
//  NotificationSettingsView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct NotificationSettingsView: View {
    var body: some View {
        VStack {
            Text("Notification Settings")
                .font(.largeTitle)
                .padding()

            // Example settings
            Toggle(isOn: .constant(true)) {
                Text("Receive Notifications")
            }
            .padding()

            Toggle(isOn: .constant(false)) {
                Text("Notification Sounds")
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Notifications")
    }
}
