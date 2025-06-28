//
//  CoinDetailsView.swift
//  CoinRanker
//
//  Created by Felix kariuki on 27/06/2025.
//

import SwiftUI
import Foundation

struct CoinDetailsView: View {
    var coinFromList: Coin
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject private var viewModel: CoinDetailsViewModel = CoinDetailsViewModel()
    
    @Environment(\.modelContext) var context
    var body: some View {
        VStack{
            VerticalSpacer(size: .extraLarge)
            headerItem
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    topCoinItem
                    
                    let change = (Double(viewModel.coin?.change ?? "0.0") ?? 0) >= 0
                    
                    if viewModel.coin?.sparkline != nil {
                        LineChartView(
                            sparklineData: viewModel.coin?.sparkline?.compactMap { Double($0 ?? "") } ?? [],
                            negativeChange: !change
                        )
                        .frame(height: 300)
                        .padding(.horizontal)
                        
                        Picker("Period Sort", selection: $viewModel.currentTimePeriod){
                            ForEach(viewModel.timePeriods, id: \.self){ period in
                                BodyMediumText(text: period).tag(period)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        .onChange(of: viewModel.currentTimePeriod){
                            viewModel.toggleTimePeriods(viewModel.currentTimePeriod)
                        }
                    }
                    
                    coinDetailsItem
                    
                    
                    VerticalSpacer(size: .medium)
                    
                    Spacer()
                }
            }
        }
        .onAppear{
            viewModel.setCoin(coinFromList)
        }
        .ignoresSafeArea()
    }
}

private extension CoinDetailsView{
    var topCoinItem: some View {
        HStack(spacing: spacing.medium){
            let percentChange =  Double(viewModel.coin?.change ?? "0") ?? 0.0
            var percentageColor: Color {
                percentChange >= 0 ? .green : .red
            }
            
            var changeText: String {
                let symbol = percentChange >= 0 ? "+" : ""
                return "\(symbol)\(String(format: "%.2f", percentChange))%"
            }
            
            CircularImageView(
                url: viewModel.coin?.iconUrl,
                size: CGSize(width: 38, height: 38)
            )
            
            VStack(alignment: .leading, spacing: spacing.small) {
                TitleMedium(
                    text: viewModel.coin?.name ?? "",
                    fontSize: 17
                )
                
                HStack(spacing: spacing.small){
                    BodyMediumText(
                        text: viewModel.coin?.symbol ?? "",
                        fontSize: 14,
                        textColor: Theme.textGray
                    )
                    
                    BodyMediumText(
                        text: "#\(viewModel.coin?.rank ?? 0)",
                        fontSize: 14,
                        textColor: Theme.textGray
                    )
                }
                
            }
            
            Spacer()
            VStack(alignment: .trailing, spacing: spacing.small){
                TitleMedium(
                    text: "$ \(viewModel.coin?.price?.toTwoDecimalPlaces() ?? "--")",
                    fontSize: 16
                )
                
                BodyLargeText(
                    text:changeText,
                    fontSize: 13,
                    textColor:percentageColor
                )
            }
            
            
        }
        .padding()
    }
}

private extension CoinDetailsView{
    var headerItem: some View {
        HStack{
            Button(action: {
                navigationRouter.navigateBack()
            }) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(Theme.onBackground)
                
            }
            Spacer()
            TitleSmall(text: "\(viewModel.coin?.name ?? "") (\(viewModel.coin?.symbol ?? "")) Details",fontSize: 20)
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

private extension CoinDetailsView{
    var coinDetailsItem: some View {
        VStack(
            alignment: .leading,
            spacing: spacing.small
        ){
            if viewModel.coin?.description != nil{
                TitleMedium(text: "What is \(viewModel.coin?.name ?? "")",fontSize: 16)
                
                BodyMediumText(text: viewModel.coin?.description ?? "",fontSize: 14)
            }
            
            VerticalSpacer(size: .extraSmall)
            TitleMedium(text: "Stats",fontSize: 17)
            VerticalSpacer(size: .extraSmall)
            
            statsItem(
                title: "Rank",
                desc: "#\(viewModel.coin?.rank ?? 0)"
            )
            
            Divider()
            
            statsItem(
                title: "Market cap",
                desc: "\(viewModel.coin?.marketCap?.formattedMarketCap() ?? "0")"
            )
            
            Divider()
            
            statsItem(
                title: "Trading volume",
                desc: "\(viewModel.coin?.the24hVolume?.formattedMarketCap() ?? "0")"
            )
            
            Divider()
            
            statsItem(
                title: "All Time High",
                desc: "\(viewModel.coin?.allTimeHigh?.price.formattedMarketCap() ?? "0")"
            )
            
            Divider()
            statsItem(
                title: "Circulating Supply",
                desc: "\(viewModel.coin?.supply?.circulating?.formattedMarketCap() ?? "0")"
            )
            Divider()
            
        }.padding(.horizontal, spacing.bigSmall)
            .padding(.vertical)
    }
    
    @ViewBuilder
    func statsItem(
        title: String,
        desc: String
    ) -> some View {
        HStack{
            BodyLargeText(text:title,fontSize: 14)
            Spacer()
            BodyMediumText(text: desc,fontSize: 13)
        }.padding([.vertical, .horizontal], spacing.small)
    }
}

#Preview {
    CoinDetailsView(coinFromList: sampleCoin)
}
