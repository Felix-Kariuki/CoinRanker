//
//  LineChartView.swift
//  CoinRanker
//
//  Created by Felix kariuki on 27/06/2025.
//

import SwiftUI
import Charts

struct LineChartView: View {
    let sparklineData: [Double]
    let negativeChange: Bool
    
    var body: some View {
        Chart {
            ForEach(sparklineData.indices, id: \.self) { index in
                LineMark(
                    x: .value("Index", index),
                    y: .value("Price", sparklineData[index])
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(!negativeChange ? .green : .red)
                .opacity(1)
            }
            
            if let baseline = sparklineData.first {
                RuleMark(y: .value("Baseline", baseline))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(.gray)
                    .opacity(0.5)
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [!negativeChange ? Color.green.opacity(0.1) : Color.red.opacity(0.1), Color.clear]),
                startPoint: .top, endPoint: .bottom
            )
        )
        .chartYScale(domain: .automatic(includesZero: false))
        .chartXScale(domain: 0...(sparklineData.count - 1))
    }
}

