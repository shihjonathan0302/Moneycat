//
//  BarChartView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/12.
//

import SwiftUI

struct VerticalBarChartView: View {
    var data: [ChartSegmentData]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw grid lines
                drawGridLines(in: geometry.size)
                
                // Draw bars on top of grid lines
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom, spacing: 8) {
                        ForEach(data, id: \.id) { segment in
                            VStack {
                                Spacer()
                                Rectangle()
                                    .fill(segment.color)
                                    .frame(
                                        width: geometry.size.width / CGFloat(data.count) * 0.8,
                                        height: CGFloat(segment.amount) / maxAmount() * geometry.size.height
                                    )
                                Text(segment.category)
                                    .font(.caption)
                                    .rotationEffect(.degrees(-45))
                                    .frame(width: geometry.size.width / CGFloat(data.count) * 0.8, alignment: .center)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    // Helper function to find the maximum amount for scaling the bars
    private func maxAmount() -> Double {
        data.map { $0.amount }.max() ?? 1
    }
    
    // Function to draw grid lines in the background
    private func drawGridLines(in size: CGSize) -> some View {
        let lineCount = 5 // Adjust number of horizontal lines
        let stepHeight = size.height / CGFloat(lineCount)
        
        return ZStack {
            // Horizontal grid lines
            ForEach(0..<lineCount, id: \.self) { index in
                Path { path in
                    let y = CGFloat(index) * stepHeight
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                }
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
            
            // Vertical grid lines for each bar section
            ForEach(Array(0...data.count), id: \.self) { index in
                Path { path in
                    let x = CGFloat(index) * (size.width / CGFloat(data.count))
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                }
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
        }
    }
}
