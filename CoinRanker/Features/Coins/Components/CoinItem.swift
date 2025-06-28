//
//  CoinItem.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import SwiftUI
import Charts

//MARK: - CoinItem SwiftUI
struct CoinItem: View {
    var coin: Coin
    var count: Int
    var isShowChart:Bool = true
    var showCount:Bool = true
    var onCoinClick: (Coin) -> Void = { _ in }

    var body: some View {
        HStack(spacing: spacing.medium) {
         
            HStack(spacing: spacing.small) {
                if count > 0 && showCount{
                    BodyLargeText(text: "\(count)",fontSize: 14)
                        .frame(minWidth: 30, maxWidth: 30, alignment: .leading)
                }
                CircularImageView(
                    url: coin.iconUrl,
                    size: CGSize(width: 35, height: 35)
                )

                VStack(alignment: .leading, spacing: spacing.small) {
                    TitleSmall(
                        text: coin.name,
                        fontSize: 16,
                        lineLimit: 1
                    )

                    BodyMediumText(
                        text: coin.symbol,
                        fontSize: 12,
                        textColor: Theme.textGray
                    )
                }.padding(.horizontal, spacing.small)
            }
            .frame(minWidth: 160, maxWidth: .infinity, alignment: .leading)

            Spacer()
        
            VStack(alignment: .leading, spacing: spacing.small) {
                TitleSmall(
                    text: "$ \(coin.price?.toTwoDecimalPlaces() ?? "--")",
                    fontSize: 16,
                    lineLimit: 1
                )
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.8)

                BodyMediumText(
                    text: "$ \(coin.marketCap?.formattedMarketCap() ?? "--")",
                    fontSize: 12,
                    textColor: Theme.textGray
                )
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            }
            .frame(minWidth: 50, maxWidth: 120, alignment: .leading)

            let percentChange =  Double(coin.change ?? "0") ?? 0.0
        
            if !isShowChart{
                HStack(
                    alignment: .center, spacing: spacing.extraSmall
                ){
                    var lineColor: Color {
                        percentChange >= 0 ? .green : .red
                    }
                    
                    var changeText: String {
                        let symbol = percentChange >= 0 ? "+" : ""
                        return "\(symbol)\(String(format: "%.2f", percentChange))%"
                    }
                    
                    BodyLargeText(
                        text:changeText,
                        fontSize: 13,
                        textColor:Theme.onPrimaryAccent
                    )
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Theme.primaryColor)
                )
            }
            
            if isShowChart{
                SparklineChartView(
                    data: parseSparkline(coin.sparkline ?? []),
                    percentChange: percentChange
                )
                .frame(minWidth: 60, maxWidth: .infinity, alignment: .trailing)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onCoinClick(coin)
        }
    }
}


struct SparklinePoint: Identifiable {
    let id = UUID()
    let index: Int
    let value: Double
}

func parseSparkline(_ values: [String?]) -> [SparklinePoint] {
    values
        .compactMap { $0 }
        .filter { $0.lowercased() != "null" }
        .compactMap { Double($0) }
        .enumerated()
        .map { SparklinePoint(index: $0.offset, value: $0.element) }
}


func calculateYRange(for data: [SparklinePoint]) -> ClosedRange<Double> {
    let values = data.map(\.value)
    
    guard let minVal = values.min(),
          let maxVal = values.max(),
          minVal != maxVal else {
        let fallback = values.first ?? 0
        return (fallback - 1)...(fallback + 1)
    }
    
    let padding = (maxVal - minVal) * 0.2
    return (minVal - padding)...(maxVal + padding)
}



let sampleSparkline = [
    "2436.39", "2450.25", "2459.87", "2446.79", "2433.35",
    "2440.68", "2442.58", "2439.65", "2439.63", "2448.63",
    "2456.61", "2458.23", "2454.02", "2440.05", "2433.03",
    "2438.75", "2445.95", "2436.19", "2434.60", "2424.74",
    "2424.72", "2424.01", "2434.78", "null"
]

struct SparklineChartView: View {
    let data: [SparklinePoint]
    let percentChange: Double
    
    var lineColor: Color {
        percentChange >= 0 ? .green : .red
    }
    
    var changeText: String {
        let symbol = percentChange >= 0 ? "+" : ""
        return "\(symbol)\(String(format: "%.2f", percentChange))%"
    }
    
    var body: some View {
        let yRange = calculateYRange(for: data)
        VStack(spacing: 0) {
            BodyLargeText(text: changeText,fontSize: 11, textColor: lineColor)
            Chart(data) {
                LineMark(
                    x: .value("Index", $0.index),
                    y: .value("Value", $0.value)
                )
                .lineStyle(StrokeStyle(lineWidth: 1))
                .interpolationMethod(.linear)
            }
            .frame(width:50,height: 30)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .foregroundColor(lineColor)
            .chartYScale(domain: yRange)
        }
    }
}

struct CoinItemShimmer: View {
    var body: some View {
        CoinItem(
            coin: sampleCoin,
            count: 2
        ).redacted(reason: .placeholder)
        .modifier(Shimmer())
    }
}

#Preview {
    VStack{
        CoinItem(
            coin: sampleCoin,
            count: 2
        )
        
        CoinItem(
            coin: sampleCoin,
            count: 200
        )
        
        SparklineChartView(
            data: parseSparkline(sampleSparkline),
            percentChange: Double(sampleCoin.change ?? "0") ?? 0.0
        )
        
        CoinItemShimmer()
    }
    
}
