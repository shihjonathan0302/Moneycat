//
//  PieChartView.swift
//  moneycat_beta
//

//import SwiftUI
//
//struct PieChartView: View {
//    var data: [ChartSegmentData]
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                let total = data.map { $0.percentage }.reduce(0, +)
//                var startAngle = Angle(degrees: 0)
//
//                // Using ForEach with valid indexing
//                ForEach(data.indices, id: \.self) { index in
//                    let segment = data[index]
//                    let endAngle = startAngle + Angle(degrees: (segment.percentage / total) * 360)
//
//                    PieSliceView(startAngle: startAngle, endAngle: endAngle, color: segment.color)
//
//                    startAngle = endAngle // Update the start angle for the next slice
//                }
//            }
//            .aspectRatio(1, contentMode: .fit)
//        }
//    }
//}
//
//struct PieSliceView: View {
//    var startAngle: Angle
//    var endAngle: Angle
//    var color: Color
//
//    var body: some View {
//        GeometryReader { geometry in
//            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
//            let radius = min(geometry.size.width, geometry.size.height) / 2
//
//            Path { path in
//                path.move(to: center)
//                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//            }
//            .fill(color)
//        }
//    }
//}
