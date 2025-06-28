//
//  NavigationRouter.swift
//  CoinRanker
//
//  Created by Felix kariuki on 27/06/2025.
//

import Foundation
import SwiftUI

class NavigationRouter:ObservableObject{
    @Published var path = NavigationPath()
    
    public enum CoinRankerDestination:Codable,Hashable{
        case favorites, details(coin:Coin)
    }
    
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func popNavigate (to destination: CoinRankerDestination) {
        path.removeLast(path.count)
        path.append(destination)
    }
    
    func navigate(to destination: CoinRankerDestination) {
        path.append(destination)
    }

    
    func navigateBack() {
        path.removeLast()
    }
}
