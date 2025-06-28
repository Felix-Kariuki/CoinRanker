//
//  CoinDetailsResponse.swift
//  CoinRanker
//
//  Created by Felix kariuki on 27/06/2025.
//

import Foundation

// MARK: - CoinDetailsResponse
struct CoinDetailsResponse: Codable {
    let status: String
    let data: CoinDetailsData
}

// MARK: - DataClass
struct CoinDetailsData: Codable {
    let coin: Coin
}

// MARK: - AllTimeHigh
struct AllTimeHigh: Codable,Equatable, Hashable {
    let price: String
    let timestamp: Int
}

// MARK: - Link
struct CoinLink: Codable , Equatable, Hashable{
    let name: String
    let url: String
    let type: String
}

// MARK: - Supply
struct Supply: Codable,Equatable, Hashable {
    let confirmed: Bool?
    let supplyAt: Int?
    let max, total: String?
    let circulating: String?
}

