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
    var percentage: Double
    var color: Color
}
