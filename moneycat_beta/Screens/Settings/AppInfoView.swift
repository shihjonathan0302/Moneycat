//
//  AppInfoView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/8.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Moneycat Beta")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Version: 1.0.0")
            Text("Developed by Jonathan Shih")
            Text("© 2024 All Rights Reserved")
            
            Spacer()
        }
        .padding()
        .navigationTitle("App Info")
    }
}
