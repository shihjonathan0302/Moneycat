//
//  TimeRange.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/8.
//

import Foundation

enum TimeRange: String, CaseIterable {
    case week
    case month
    case year

    var calendarComponent: Calendar.Component {
        switch self {
        case .week: return .weekOfYear
        case .month: return .month
        case .year: return .year
        }
    }
}
