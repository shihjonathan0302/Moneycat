//
//  Color.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/7.
//

import SwiftUI
import RealmSwift

class PersistableColor: EmbeddedObject {
    @Persisted var red: Double = 0
    @Persisted var green: Double = 0
    @Persisted var blue: Double = 0
    @Persisted var opacity: Double = 1.0

    // Initializes PersistableColor from a SwiftUI Color
    convenience init(color: Color) {
        self.init()
        let uiColor = UIColor(color)
        if let components = uiColor.cgColor.components, components.count >= 3 {
            red = Double(components[0])
            green = Double(components[1])
            blue = Double(components[2])
            opacity = components.count == 4 ? Double(components[3]) : 1.0
        }
    }

    // Converts PersistableColor to UIColor
    func toUIColor() -> UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(opacity))
    }
}

extension Color {
    // Initialize SwiftUI Color from PersistableColor
    init(persistableColor: PersistableColor) {
        self.init(.sRGB, red: persistableColor.red, green: persistableColor.green, blue: persistableColor.blue, opacity: persistableColor.opacity)
    }

    // Hex to to Color converter
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
