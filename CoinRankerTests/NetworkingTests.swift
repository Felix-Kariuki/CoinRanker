//
//  NetworkingTests.swift
//  CoinRanker
//
//  Created by Felix kariuki on 28/06/2025.
//

import XCTest
@testable import CoinRanker
import Combine

final class NetworkingTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var repository: CoinsRepository!
    
    override func setUp() {
        super.setUp()
        repository = CoinsRepositoryImpl()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        repository = nil
        super.tearDown()
    }
    
    func test_get_coins_is_successful() {
        let expectation = XCTestExpectation()
        let limit: Int32 = 20
        let offset: Int32 = 0
        let orderBy: [String]? = nil
        
        var coinResponse: CoinResponse?
        var coinError: APIError?
        
        repository.getCoins(limit: limit, offset: offset, orderBy: orderBy)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        coinError = error
                        expectation.fulfill()
                    case .finished:
                        break
                    }
                },
                receiveValue: { response in
                    coinResponse = response
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        
        wait(for: [expectation], timeout: 10.0)
        
        // Verify
        XCTAssertNil(coinError)
        XCTAssertNotNil(coinResponse)
        
        if let response = coinResponse {
            XCTAssertEqual(response.status, "success")
            
            let data = response.data
            XCTAssertNotNil(data.stats)
            XCTAssertNotNil(data.coins)
            XCTAssertFalse(data.coins.isEmpty)
            
            
            let firstCoin = data.coins[0]
            XCTAssertEqual(firstCoin.uuid, "Qwsogvtv82FCd")
        }
    }
    
    func test_get_coin_by_id_is_successful() {
        let expectation = XCTestExpectation()
      
        let uuid:String = "Qwsogvtv82FCd"
        let period:String = ""
        
        var coinResponse: CoinDetailsResponse?
        var coinError: APIError?
        
        repository.getcoinDetails(uuid: uuid, timePeriod: period)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        coinError = error
                        expectation.fulfill()
                    case .finished:
                        break
                    }
                },
                receiveValue: { response in
                    coinResponse = response
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        
        wait(for: [expectation], timeout: 10.0)
        
        // Verify
        XCTAssertNil(coinError)
        XCTAssertNotNil(coinResponse)
        
        if let response = coinResponse {
            XCTAssertEqual(response.status, "success")
            
            let data = response.data
            XCTAssertNotNil(data.coin)
            
            // verify got the details of the coin
            XCTAssertEqual(data.coin.uuid, "Qwsogvtv82FCd")
        }
    }
    
    
    func test_get_coins_with_limit_offset_gets_limit_coins() {
          let expectation = XCTestExpectation()
          let limit: Int32 = 20
          let offset: Int32 = 0
          
          var coinResponse: CoinResponse?
          var coinError: APIError?
          
 
          repository.getCoins(limit: limit, offset: offset, orderBy: nil)
              .sink(
                  receiveCompletion: { completion in
                      switch completion {
                      case .failure(let error):
                          coinError = error
                          expectation.fulfill()
                      case .finished:
                          break
                      }
                  },
                  receiveValue: { response in
                      coinResponse = response
                      expectation.fulfill()
                  }
              )
              .store(in: &cancellables)


          wait(for: [expectation], timeout: 10.0)
          
          XCTAssertNil(coinError)
          XCTAssertNotNil(coinResponse)
          
          if let response = coinResponse {
              XCTAssertEqual(response.status, "success")
    
              XCTAssertLessThanOrEqual(response.data.coins.count, Int(limit))
          }
      }
  
    func test_get_coin_details_with_invalid_uuid() {
    
         let expectation = XCTestExpectation()
         let invalidUuid = "invalid-uuid-123"
         let timePeriod = "24h"
         
         var coinError: APIError?
 
         repository.getcoinDetails(uuid: invalidUuid, timePeriod: timePeriod)
             .sink(
                 receiveCompletion: { completion in
                     switch completion {
                     case .failure(let error):
                         coinError = error
                         expectation.fulfill()
                     case .finished:
                         break
                     }
                 },
                 receiveValue: { _ in
                     expectation.fulfill()
                 }
             )
             .store(in: &cancellables)
         

         wait(for: [expectation], timeout: 10.0)
         
         XCTAssertNotNil(coinError)
     }
}

