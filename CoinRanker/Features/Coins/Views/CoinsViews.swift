//
//  CoinsViews.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import SwiftUI
import SwiftData

struct CoinsViews: View {
    
    @Environment(\.modelContext) var context
    @StateObject private var viewModel: CoinsViewModel = CoinsViewModel()
    @EnvironmentObject var navigationRouter: NavigationRouter
    @State private var showFilterSheet: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                VerticalSpacer(size: .extraLarge)
                headerItem
                
                if viewModel.isLoading && viewModel.coins.isEmpty {
                    ShimmerCoins()
                } else if viewModel.coins.isEmpty && !viewModel.isLoading  && viewModel.errorMessage != nil{
                    Spacer()
                    EmptyStateItem(
                        title: "Error",
                        description: viewModel.errorMessage ?? "An error Occured while fetching coins",
                        showRetryButton: true, showError: true,
                        onRetry: {
                            viewModel.fetchCoins()
                        }
                    )
                    Spacer()
                    Spacer()
                } else if !viewModel.isLoading && viewModel.coins.isEmpty {
                    //  empty view
                    Spacer()
                    EmptyStateItem()
                    Spacer()
                    Spacer()
                } else {
                    CoinsTableHeader().frame(height: 38)
                    listView
                    
                    Spacer()
                }
                
                
            }
            .ignoresSafeArea()
            .onAppear{
                viewModel.makeInitialCall(context)
            }
            
            BottomSheetView(isShowing: $showFilterSheet) {
                FilterBottomSheet(
                    onCancel: {
                        showFilterSheet.toggle()
                    }, onApply: {
                        viewModel.filterCoins()
                        showFilterSheet.toggle()
                    },
                    viewModel: viewModel
                )
            }
        }
    }
}

private extension CoinsViews {
    var listView: some View {
        List {
            ForEach(viewModel.coins.indices, id: \.self) { index in
                let item = viewModel.coins[index]
                CoinItem(coin: item,
                         count: item.rank ?? index + 1,
                         showCount: viewModel.filtersStrings.isEmpty || viewModel.filtersStrings.count == 2,
                         onCoinClick: { coinNavigate in
                    navigationRouter.navigate(to: .details(coin: coinNavigate))
                })
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
            
            if viewModel.offset < 100, !viewModel.isLoading {
                HStack {
                    Spacer()
                    Button("View More") {
                        viewModel.fetchCoins()
                    }
                    .font(.body)
                    .foregroundColor(.accentColor)
                    Spacer()
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
            VStack {
                let text = viewModel.favoriteCoins.contains(where: { $0.uuid == coin.uuid }) ? "unfavorite" : "favorite"
                BodyMediumText(text: text)
            }
        }
        .tint(
            viewModel.favoriteCoins.contains(where: { $0.uuid == coin.uuid }) ? Color.red : Color.green
        )
    }
}

private extension CoinsViews{
    var headerItem: some View {
        HStack(alignment:.center, spacing: spacing.medium){
            VStack(alignment: .leading,spacing: spacing.small){
                TitleLarge(text: "appname")
                    .accessibilityIdentifier("appTitle")
                BodyMediumText(text: "Live Market Pulse",textColor: Theme.textGray)
            }
            Spacer()
            ZStack(alignment: .topTrailing){
                Image(systemName: "heart.fill")
                    .onTapGesture {
                        navigationRouter.navigate(to: .favorites)
                    }
                
                if viewModel.favoriteCoins.count > 0 {
                    BodyLargeText(text:"\(viewModel.favoriteCoins.count)",fontSize: 12, textColor: Theme.onPrimaryAccent)
                        .padding(4)
                        .background(Color.green)
                        .clipShape(Circle())
                        .offset(x: 8, y: -10)
                    
                }
            }
            .accessibilityIdentifier("favIcon")
            
            ZStack{
                SVGIcon("Filter",color:Theme.onBackground)
                    .onTapGesture {
                        showFilterSheet.toggle()
                    }
                
                if viewModel.filtersStrings.count > 0 {
                    BodyLargeText(text:"\(viewModel.filtersStrings.count)",fontSize: 12, textColor: Theme.onPrimaryAccent)
                        .padding(4)
                        .background(Color.green)
                        .clipShape(Circle())
                        .offset(x: 8, y: -10)
                    
                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct ShimmerCoins : View{
    var body : some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(1...20, id: \.self) { _ in
                    CoinItemShimmer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    CoinsViews()
}
