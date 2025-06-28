//
//  APIError.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case errorMessage(String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self{
        case .decodingError:
            return "Failed to decode error from the service"
        case .errorCode(let code):
            return "\(code) - Something Went Wrong"
        case .unknown:
            return "The error is unknown"
        case .errorMessage(let msg):
            return msg
        }
        
    }
}


struct ErrorResponse: Decodable {
    let message: String
    let errors: [String]?
    let code: String?
}

extension ErrorResponse {
    static func defaultErrorMessage() -> ErrorResponse {
        return ErrorResponse(message: "Something went wrong!", errors: [], code: nil)
    }
}
