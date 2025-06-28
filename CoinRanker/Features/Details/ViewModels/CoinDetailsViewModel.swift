//
//  CoinDetailsViewModel.swift
//  CoinRanker
//
//  Created by Felix kariuki on 27/06/2025.
//

import Foundation
import Combine
import SwiftData
import TimberIOS

@MainActor
class CoinDetailsViewModel: ObservableObject {
    
    @Published var coin: Coin? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var uuid: String = ""
    @Published var currentTimePeriod: String = "24h"
    let timePeriods = ["1h", "3h", "12h", "24h", "7d", "30d", "3m", "1y", "3y", "5y"]
    
    private var repository:CoinsRepository = CoinsRepositoryImpl()
    private var cancellables = Set<AnyCancellable>()
    var context: ModelContext?
    
    
    init(repository: CoinsRepository = CoinsRepositoryImpl()){
        self.repository = repository
    }
    
    func setCoin(_ coin: Coin) {
        self.uuid = coin.uuid
        self.coin = coin
        
        getCoindDetails(timePeriod: currentTimePeriod)
    }

    
    func toggleTimePeriods(_ period:String) {
        currentTimePeriod = period
        
        if let id = coin?.uuid {
            self.uuid = id
            getCoindDetails(timePeriod: period)
        }
    }
    
    private func getCoindDetails(timePeriod:String) {
        guard uuid.isEmpty == false else { return }
        isLoading = true
        
        repository.getcoinDetails(uuid: uuid, timePeriod: timePeriod)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                
            }, receiveValue: { [weak self] response in
                self?.coin = response.data.coin
            })
            .store(in: &cancellables)
    }
}
