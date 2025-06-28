//
//  CoinApiService.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Foundation

struct Endpoint: ApiBuilder {
    let path: String

    var baseUrl: URL { URL(string: "https://api.coinranking.com/v2")! }

    var urlRequest: URLRequest {
        URLRequest(url: baseUrl.appendingPathComponent(path))
    }
}

protocol ApiBuilder {
    var urlRequest:URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}
