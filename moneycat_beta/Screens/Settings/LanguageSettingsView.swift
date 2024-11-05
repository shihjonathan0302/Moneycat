//
//  LanguageSettingsView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct LanguageSettingsView: View {
    let languages = [
        ("English", "en"),
        ("Traditional Chinese", "zh-Hant"),
        ("Simplified Chinese", "zh-Hans"),
        ("Japanese", "ja")
    ]

    // Placeholder for currently selected language code
    @State private var selectedLanguageCode = "en"

    var body: some View {
        List(languages, id: \.1) { language, code in
            HStack {
                Text(language)
                Spacer()
                if selectedLanguageCode == code {
                    Image(systemName: "checkmark").foregroundColor(.blue)
                }
            }
            .onTapGesture {
                // Update the selected language code on tap
                self.selectedLanguageCode = code
            }
        }
        .navigationBarTitle("Language Settings")
    }
}
