//
//  PieChartView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/11/27.
//

import SwiftUI

struct PieChartView: View {
    var data: [ChartSegmentData]

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: 12) {
                // Scrollable Legend
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) { // Increased spacing slightly
                        ForEach(data.indices, id: \.self) { index in
                            let segment = data[index]
                            HStack(spacing: 10) { // Increased space between circle and text
                                Circle()
                                    .fill(colorForSegment(at: index))
                                    .frame(width: 10, height: 10) // Slightly larger circle
                                Text("\(segment.category): \(Int(segment.amount * 100))%")
                                    .font(.footnote) // Slightly larger text for the legend
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                }
                .frame(width: geometry.size.width * 0.4) // Legend now occupies 40% of the width
                .padding(.top, 8)

                // Vertical Divider
                Divider()
                    .frame(height: geometry.size.height * 0.9)
                    .background(Color.gray.opacity(0.5))

                // Pie Chart
                ZStack {
                    ForEach(data.indices, id: \.self) { index in
                        PieSliceView(
                            startAngle: startAngle(for: index),
                            endAngle: endAngle(for: index),
                            color: colorForSegment(at: index)
                        )
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(width: geometry.size.width * 0.48) // Reduced pie chart width slightly
                .padding(.top, 8)
                .padding(.bottom, 8)
                .offset(x: -20) // Moves the pie chart slightly to the left
            }
            .frame(maxWidth: geometry.size.width - 20) // Narrower HStack width
            .padding(10)
            .background(Color(.systemGray5))
            .cornerRadius(10)
        }
    }

    // MARK: - Angle Calculations

    private func startAngle(for index: Int) -> Angle {
        let total = data.map(\.amount).reduce(0, +)
        let startAmount = data.prefix(index).map(\.amount).reduce(0, +)
        return .degrees(startAmount / total * 360.0 - 90.0)
    }

    private func endAngle(for index: Int) -> Angle {
        let total = data.map(\.amount).reduce(0, +)
        let endAmount = data.prefix(index + 1).map(\.amount).reduce(0, +)
        return .degrees(endAmount / total * 360.0 - 90.0)
    }

    // MARK: - Color for Segment
    private func colorForSegment(at index: Int) -> Color {
        let colors: [Color] = [
            Color(red: 1, green: 0.6, blue: 0.1, opacity: 0.9), // Vibrant Deep Orange
            Color(red: 1, green: 0.7, blue: 0.3, opacity: 0.9), // Vibrant Coral
            Color(red: 1, green: 0.8, blue: 0.4, opacity: 0.9), // Vibrant Pale Orange
            Color(red: 1, green: 0.85, blue: 0.5, opacity: 0.9), // Vibrant Apricot
            Color(red: 1, green: 0.75, blue: 0.2, opacity: 0.9), // Vibrant Golden Yellow
            Color(red: 0.95, green: 0.65, blue: 0.1, opacity: 0.9), // Vibrant Ochre
            Color(red: 1, green: 0.9, blue: 0.6, opacity: 0.9) // Vibrant Light Orange
        ]
        return colors[index % colors.count] // Cycle through these more vibrant colors
    }
}

struct PieSliceView: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color

    var body: some View {
        Path { path in
            let center = CGPoint(x: 100, y: 100)
            let radius: CGFloat = 80.0
            path.move(to: center)
            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
        }
        .fill(color)
    }
}

