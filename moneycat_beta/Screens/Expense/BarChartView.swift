//
//  BarChartView.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/10/12.
//

import SwiftUI

struct BarChartView: View {
    var data: [ChartSegmentData]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ForEach(data.indices, id: \.self) { index in
                    let segment = data[index]
                    HStack {
                        Text(segment.category)
                            .frame(width: 100, alignment: .leading)
                        Rectangle()
                            .fill(segment.color)
                            .frame(width: CGFloat(segment.percentage) * geometry.size.width, height: 20)
                    }
                }
            }
        }
        .padding()
    }
}
