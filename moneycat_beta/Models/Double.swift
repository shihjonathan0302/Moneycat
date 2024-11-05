//
//  Double.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/8.
//

import Foundation

extension Double {
    func roundTo(_ maximumFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumFractionDigits = 0
        formatter.decimalSeparator = "."
        return formatter.string(for: self) ?? String(format: "%.\(maximumFractionDigits)f", self)
    }
}
