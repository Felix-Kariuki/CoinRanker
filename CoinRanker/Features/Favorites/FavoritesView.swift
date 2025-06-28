//
//  FavoritesView.swift
//  CoinRanker
//
//  Created by Felix kariuki on 26/06/2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(\.modelContext) var context
    @StateObject private var viewModel: CoinsViewModel = CoinsViewModel()
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        VStack{
            headerItem
            
            if viewModel.isLocalLoading && viewModel.favoriteCoins.isEmpty {
                ShimmerCoins()
            } else if !viewModel.isLocalLoading && viewModel.favoriteCoins.isEmpty {
                //  empty view
                Spacer()
                EmptyStateItem()
                Spacer()
                Spacer()
                
            } else {
                listView
                Spacer()
            }
            
        }
        .onAppear{
            viewModel.makeInitialCall(context)
        }
    }
}

private extension FavoritesView {
    var listView: some View {
        List {
            ForEach(viewModel.favoriteCoins.indices, id: \.self) { index in
                let item = viewModel.favoriteCoins[index].toCoin()
                CoinItem(coin: item,
                         count: index + 1,
                         onCoinClick: { coin in
                    navigationRouter.navigate(to: .details(coin: coin))
                }
                )
                .onAppear {
                    if index == viewModel.coins.count - 1 {
                        viewModel.fetchCoins()
                    }
                }
                .swipeActions(edge: .trailing) {
                    favouriteAction(coin: item)
                }
                .listRowSeparator(.hidden)
            }
            
            ForEach(1...2, id: \.self) { _ in
                VerticalSpacer(size: .large)
                    .listRowSeparator(.hidden)
            }

        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
    
    private func favouriteAction(coin:Coin) -> some View {
        
        
        Button {
            viewModel.favouriteAction(context, coin: coin)
        } label: {
       
                let text = viewModel.favoriteCoins.contains(where: { $0.uuid == coin.uuid }) ? "unfavorite" : "favorite"
                BodyMediumText(text: text)
        
        }
        .tint(
            viewModel.favoriteCoins.contains(where: { $0.uuid == coin.uuid }) ? Color.red : Color.green
        )
    }
}

private extension FavoritesView{
    var headerItem: some View {
        HStack(spacing:spacing.medium){
            Button(action: {
                navigationRouter.navigateBack()
            }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(Theme.onBackground)
    
            }
       
            Spacer()
            TitleMedium(text: "favorites",fontSize: 22)
                .accessibilityIdentifier("favorites")
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    FavoritesView()
}
