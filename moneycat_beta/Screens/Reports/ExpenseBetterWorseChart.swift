//
//  ExpenseBetterWorseChart.swift
//  moneycat_beta
//
//  Created by Jonathan Shih on 2024/11/9.
//

import SwiftUI
import Charts

struct ExpenseBetterWorseChart: View {
    @ObservedObject var realmManager: RealmManager // Observe RealmManager changes

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("Attractive")
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.leading, 5)
                    Spacer()
                    Text("Indifferent")
                        .foregroundColor(.blue)
                        .font(.caption)
                        .padding(.trailing, 5)
                }
                Spacer()
                HStack {
                    Text("Must")
                        .foregroundColor(.yellow)
                        .font(.caption)
                        .padding(.leading, 5)
                    Spacer()
                    Text("One-Dimensional")
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.trailing, 5)
                }
            }
            .zIndex(1)

            Chart {
                RectangleMark(xStart: .value("Left", -100), xEnd: .value("Right", -50),
                              yStart: .value("Bottom", 0), yEnd: .value("Top", 50))
                    .foregroundStyle(Color.yellow.opacity(0.15))

                RectangleMark(xStart: .value("Left", -50), xEnd: .value("Right", 0),
                              yStart: .value("Bottom", 0), yEnd: .value("Top", 50))
                    .foregroundStyle(Color.red.opacity(0.15))

                RectangleMark(xStart: .value("Left", -100), xEnd: .value("Right", -50),
                              yStart: .value("Bottom", 50), yEnd: .value("Top", 100))
                    .foregroundStyle(Color.green.opacity(0.15))

                RectangleMark(xStart: .value("Left", -50), xEnd: .value("Right", 0),
                              yStart: .value("Bottom", 50), yEnd: .value("Top", 100))
                    .foregroundStyle(Color.blue.opacity(0.15))

                // Filter out invalidated expenses
                ForEach(realmManager.observedExpenses.filter { !$0.isInvalidated }, id: \.id) { expense in
                    let better = expense.betterCoefficient
                    let worse = expense.worseCoefficient
                    let categoryColor = expense.category?.color?.toUIColor() ?? UIColor.gray

                    PointMark(
                        x: .value("Worse", worse),
                        y: .value("Better", better)
                    )
                    .foregroundStyle(Color(uiColor: categoryColor))
                    .symbolSize(100)
                }

                RuleMark(y: .value("50% Better", 50))
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundStyle(.gray.opacity(0.5))

                RuleMark(x: .value("50% Worse", -50))
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundStyle(.gray.opacity(0.5))
            }
            .padding()
            .chartXScale(domain: -100...0)
            .chartYScale(domain: 0...100)
        }
    }
}
