//
//  CoinResponse.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Foundation


// MARK: - CoinResponse
struct CoinResponse: Codable {
    let status: String
    let data: CoinData
}

// MARK: - CoinData
struct CoinData: Codable {
    let stats: Stats?
    let coins: [Coin]
    
    enum CodingKeys: String, CodingKey {
        case stats = "stats"
        case coins = "coins"
    }
}

// MARK: - Stats
struct Stats: Codable {
    let total: Int
    let totalCoins: Int
    let totalMarkets: Int
    let totalExchanges: Int
    let totalMarketCap: String
    let total24hVolume: String

    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24hVolume = "total24hVolume"
    }
}

// MARK: - Coin
struct Coin: Codable, Identifiable,Hashable {
    var id: String { uuid }

    let uuid: String
    let symbol: String
    let name: String

    let color: String?
    let iconUrl: String?
    let marketCap: String?
    let price: String?
    let listedAt: Int?
    let tier: Int?
    let change: String?
    let rank: Int?
    let sparkline: [String?]?
    let lowVolume: Bool?
    let coinrankingUrl: String?
    let btcPrice: String?
    let isWrappedTrustless: Bool?
    let wrappedTo: String?

    let description: String?
    let websiteUrl: String?
    let links: [CoinLink]?
    let supply: Supply?
    let numberOfMarkets: Int?
    let numberOfExchanges: Int?
    let the24hVolume: String?
    let fullyDilutedMarketCap: String?
    let priceAt: Int?
    let allTimeHigh: AllTimeHigh?
    let hasContent: Bool?
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
            case coinrankingUrl = "coinrankingUrl"
            case iconUrl = "iconUrl"
            case btcPrice = "btcPrice"
            case isWrappedTrustless, wrappedTo

            case description, websiteUrl, links, supply
            case numberOfMarkets, numberOfExchanges
            case the24hVolume = "24hVolume"
            case fullyDilutedMarketCap, priceAt
            case allTimeHigh, hasContent, tags
    }
}


let sampleCoin = Coin(
    uuid: "Qwsogvtv82FCd",
    symbol: "BTC",
    name: "Bitcoin",
    color: "#f7931A",
    iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
    marketCap: "2138456542110",
    price: "107550.36736651631",
    listedAt: 1279324800,
    tier: 1,
    change: "2.08",
    rank: 1,
    sparkline: [
        "105376.33115532299", "105541.20384428787", "105538.30020612566",
        "105984.18184724721", "105851.03578590689", "105504.42617282478",
        "105770.38444706402", "105986.77633953516", "105925.87783441908",
        "105921.96913620287", "106140.22023143808", "106337.36327690612",
        "106589.7416801117", "106474.47054227091", "106215.18395482766",
        "106241.30091893283", "106348.27879434725", "106553.17503866267",
        "106523.92970973876", "106771.39083096231", "106940.31261749305",
        "107101.4572667664", "107116.07040280358", nil
    ],
    lowVolume: false,
    coinrankingUrl: "https://coinranking.com/coin/Qwsogvtv82FCd+bitcoin-btc",
    btcPrice: "1",
    isWrappedTrustless: false,
    wrappedTo: nil,
    
    description: "Bitcoin is a digital currency with a finite supply, allowing users to send/receive money without a central bank/government, often nicknamed \"Digital Gold\".",
    websiteUrl: "https://bitcoin.org",
    links: [
        CoinLink(name: "coinmarketcap.com", url: "https://coinmarketcap.com/currencies/bitcoin/", type: "cmc"),
        CoinLink(name: "bitcoin.org", url: "https://bitcoin.org", type: "website"),
        CoinLink(name: "bitcoinmagazine.com", url: "https://bitcoinmagazine.com/", type: "website"),
        CoinLink(name: "bitcointalk.org", url: "https://bitcointalk.org/", type: "bitcointalk"),
        CoinLink(name: "blockchain.com", url: "https://www.blockchain.com/explorer", type: "explorer"),
        CoinLink(name: "bitcoin/bitcoin", url: "https://github.com/bitcoin/bitcoin", type: "github"),
        CoinLink(name: "r/bitcoin", url: "https://www.reddit.com/r/bitcoin/", type: "reddit"),
        CoinLink(name: "Bitcoin_Magazine", url: "https://t.me/Bitcoin_Magazine", type: "telegram"),
        CoinLink(name: "bitcoin", url: "https://t.me/bitcoin", type: "telegram"),
        CoinLink(name: "Bitcoin Whitepaper", url: "https://bitcoin.org/bitcoin.pdf", type: "whitepaper")
    ],
    supply: Supply(
        confirmed: true,
        supplyAt: 1751048462,
        max: "21000000",
        total: "19884262",
        circulating: "19884262"
    ),
    numberOfMarkets: 1969,
    numberOfExchanges: 94,
    the24hVolume: "27739826471",
    fullyDilutedMarketCap: "2242410165244",
    priceAt: 1751048400,
    allTimeHigh: AllTimeHigh(
        price: "111937.14617252293",
        timestamp: 1747939200
    ),
    hasContent: true,
    tags: ["layer-1", "proof-of-work", "halal", "dino"]
)

