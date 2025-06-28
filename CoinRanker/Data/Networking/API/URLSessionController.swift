//
//  URLSessionController.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Combine
import Foundation
import TimberIOS
import UIKit

let CONNECTION_TIMEOUT: TimeInterval = 60.0

extension URLSession {
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: String = RequestType.GET,
        body: Data? = nil,
        queryParameters: [String: Any]? = nil,
        timeoutInterval: TimeInterval = CONNECTION_TIMEOUT
    ) -> AnyPublisher<T, APIError> {
        var request = endpoint.urlRequest
        
        request.timeoutInterval = timeoutInterval
        
        // Add query parameters to the URL
        if let queryParams = queryParameters, !queryParams.isEmpty {
            request.url = addQueryParameters(to: request.url, parameters: queryParams)
        }
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "COIN_API_KEY") ?? ""
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .timeout(.seconds(timeoutInterval), scheduler: DispatchQueue.global())
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    // Handle server errors
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        if let detailedErrors = errorResponse.errors, !detailedErrors.isEmpty {
                            throw APIError.errorMessage(detailedErrors.joined(separator: "\n"))
                        }
                        throw APIError.errorMessage(errorResponse.message)
                    }
                    
                    throw APIError.errorCode(httpResponse.statusCode)
                }
                
                networkLogger(request, response: response as? HTTPURLResponse, data: data)
                return data
            }
            .decode(type: T.self, decoder: customDecoder())
            .receive(on: DispatchQueue.main) // Receive results on main queue
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                }
                
            
                if error is URLError && (error as! URLError).code == .timedOut {
                    Timber.e("Request timed out after \(timeoutInterval) seconds")
                    return APIError.errorMessage("Request timed out. Please check your connection and try again.")
                }
                
                Timber.e("Networking Error... \(error.localizedDescription)")
                return APIError.errorMessage(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    private func addQueryParameters(to url: URL?, parameters: [String: Any]) -> URL? {
        guard let url = url else { return nil }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = components?.queryItems ?? []
        
        for (key, value) in parameters {
    
            if value is NSNull {
                continue
            }
            
          
            if let array = value as? [String] {
                for arrayValue in array {
                    if !arrayValue.isEmpty {
                        queryItems.append(URLQueryItem(name: key, value: arrayValue))
                    }
                }
                continue
            }
            

            if let array = value as? [Any] {
                for arrayValue in array {
                    let stringValue = stringFromValue(arrayValue)
                    if !stringValue.isEmpty {
                        queryItems.append(URLQueryItem(name: key, value: stringValue))
                    }
                }
                continue
            }
            
            let stringValue = stringFromValue(value)
            if !stringValue.isEmpty {
                queryItems.append(URLQueryItem(name: key, value: stringValue))
            }
        }
        
        components?.queryItems = queryItems
        return components?.url
    }
    
    private func stringFromValue(_ value: Any) -> String {
        if let string = value as? String {
            return string
        } else if let number = value as? NSNumber {
            return number.stringValue
        } else if let bool = value as? Bool {
            return bool ? "true" : "false"
        } else {
            return String(describing: value)
        }
    }
    
    private func customDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    

}
