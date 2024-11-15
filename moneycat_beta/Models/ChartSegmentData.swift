//
//  ChartSegmentData.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/8.
//

import SwiftUI

struct ChartSegmentData: Identifiable {
    let id = UUID()
    var category: String
    var amount: Double // Updated to store the amount rather than percentage
    var color: Color
}

