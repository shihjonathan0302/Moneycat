//
//  PrivacyPolicyView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .padding(.bottom)

                Text("""
                This is the privacy policy of Moneycat Beta.
                
                Your data privacy is important to us. We only collect the necessary data to improve the app experience. No personal information will be shared with third parties without consent.
                
                Please review the full privacy policy for more details.
                """)
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}
