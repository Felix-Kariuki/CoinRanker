//
//  LocalCoin.swift
//  CoinRanker
//
//  Created by Felix kariuki on 26/06/2025.
//

import Foundation
import SwiftData

@Model
class FavoriteCoin: Identifiable {
    var id: UUID = UUID()
    var uuid: String
    var name: String
    var symbol: String
    var iconUrl: String?
    var sparkline: [String?]?
    var price: String?
    var timeStamp: Int64 = Date().timestamp
    
    var color: String?
    var marketCap: String?
    var listedAt: Int?
    var tier: Int?
    var change: String?
    var rank: Int?
    var lowVolume: Bool?
    var coinrankingUrl: String?
    var btcPrice: String?
    var isWrappedTrustless: Bool?
    var wrappedTo: String?
    var coinDescription: String?
    
    init(id: UUID = UUID(), uuid: String, name: String, symbol: String, iconUrl: String?, sparkline: [String?]? = nil, price: String? = nil,
         timeStamp: Int64, color: String? = nil, marketCap: String? = nil, listedAt: Int? = nil, tier: Int? = nil, change: String? = nil,
         rank: Int? = nil, lowVolume: Bool? = nil, coinrankingUrl: String? = nil, btcPrice: String? = nil, isWrappedTrustless: Bool? = nil,
         wrappedTo: String? = nil, description: String? = nil
    ) {
        self.id = id
        self.uuid = uuid
        self.name = name
        self.symbol = symbol
        self.iconUrl = iconUrl
        self.sparkline = sparkline
        self.price = price
        self.timeStamp = timeStamp
        self.color = color
        self.marketCap = marketCap
        self.listedAt = listedAt
        self.tier = tier
        self.change = change
        self.rank = rank
        self.lowVolume = lowVolume
        self.coinrankingUrl = coinrankingUrl
        self.btcPrice = btcPrice
        self.isWrappedTrustless = isWrappedTrustless
        self.wrappedTo = wrappedTo
        self.coinDescription = description
    }
}
