//
//  GetCoinsRepository.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Foundation
import Combine

protocol CoinsRepository {
    func getCoins(limit: Int32?,offset: Int32?,orderBy: [String]?) -> AnyPublisher<CoinResponse, APIError>
    
    func getcoinDetails(uuid:String, timePeriod:String) -> AnyPublisher<CoinDetailsResponse, APIError>
}

struct CoinsRepositoryImpl: CoinsRepository {
    func getcoinDetails(uuid: String, timePeriod: String) -> AnyPublisher<CoinDetailsResponse, APIError> {
        let queryParams: [String: Any] = [
            "timePeriod": timePeriod
        ]
        
        return URLSession.shared.request(
            Endpoint(path: "coin/\(uuid)"),
            decodingType: CoinDetailsResponse.self,
            queryParameters: queryParams
        )
    }
    
    func getCoins(
        limit: Int32? = 20,
        offset: Int32? = 0,
        orderBy: [String]? = nil
    ) -> AnyPublisher<CoinResponse, APIError> {
        
        var queryParams: [String: Any] = [
            "limit": limit ?? 20,
            "offset": offset ?? 0
        ]
        
        
        if let orderByValues = orderBy, !orderByValues.isEmpty {
            queryParams["orderBy"] = orderByValues
        }

        return URLSession.shared.request(
            Endpoint(path: "coins"),
            decodingType: CoinResponse.self,
            queryParameters: queryParams
        )
    }
    
    
}
