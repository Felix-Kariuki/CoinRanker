//
//  CoinRankerApp.swift
//  CoinRanker
//
//  Created by Felix kariuki on 24/06/2025.
//

import SwiftUI

@main
struct CoinRankerApp: App {
    
    @StateObject private var navigationRouter = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationRouter.path,root: {
                CoinsViews().navigationDestination(
                    for: NavigationRouter.CoinRankerDestination.self
                ){ destination in
                    switch destination {
                    case .favorites:
                        FavoritesView()
                            .environmentObject(navigationRouter)
                            .navigationBarBackButtonHidden(true)
                        
                    case .details(let coin):
                        CoinDetailsView(coinFromList:coin)
                            .environmentObject(navigationRouter)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .environmentObject(navigationRouter)
            })
        }
        .modelContainer(for: [FavoriteCoin.self])
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


extension View {
    
    func customNavigationBar(navigate: @escaping () -> Void) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        navigate()
                    }) {
                        HStack {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(Theme.onBackground)
                            Spacer()
                        }
                    }
                }
            }
        
    }
}
