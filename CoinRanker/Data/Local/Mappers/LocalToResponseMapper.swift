//
//  LocalToResponseMapper.swift
//  CoinRanker
//
//  Created by Felix kariuki on 26/06/2025.
//

import Foundation


// MARK: - Coin to FavoriteCoin Mapper
extension Coin {
    func toFavoriteCoin() -> FavoriteCoin {
        return FavoriteCoin(
            uuid: uuid,
            name: name,
            symbol: symbol,
            iconUrl: iconUrl,
            sparkline: sparkline,
            price: price,
            timeStamp: Date().timestamp,
            color: color,
            marketCap: marketCap,
            listedAt: listedAt,
            tier: tier,
            change: change,
            rank: rank,
            lowVolume: lowVolume,
            coinrankingUrl: coinrankingUrl,
            btcPrice: btcPrice,
            isWrappedTrustless: isWrappedTrustless,
            wrappedTo: wrappedTo
        )
    }
}

// MARK: - FavoriteCoin to Coin Mapper
extension FavoriteCoin {
    func toCoin() -> Coin {
        return Coin(
            uuid: uuid,
            symbol: symbol,
            name: name,
            color: color,
            iconUrl: iconUrl,
            marketCap: marketCap,
            price: price,
            listedAt: listedAt,
            tier: tier,
            change: change,
            rank: rank,
            sparkline: sparkline,
            lowVolume: lowVolume,
            coinrankingUrl: coinrankingUrl,
            btcPrice: btcPrice,
            isWrappedTrustless: isWrappedTrustless,
            wrappedTo: wrappedTo,
            description: coinDescription,
            websiteUrl: "",
            links: nil,
            supply: nil,
            numberOfMarkets: nil,
            numberOfExchanges: nil,
            the24hVolume: nil,
            fullyDilutedMarketCap: nil,
            priceAt: nil,
            allTimeHigh: nil,
            hasContent: nil,
            tags: nil
        )
    }
}

// MARK: - Collection Extensions for Batch Mapping
extension Array where Element == Coin {
    func toFavoriteCoins() -> [FavoriteCoin] {
        return map { $0.toFavoriteCoin() }
    }
}

extension Array where Element == FavoriteCoin {
    func toCoins() -> [Coin] {
        return map { $0.toCoin() }
    }
}

