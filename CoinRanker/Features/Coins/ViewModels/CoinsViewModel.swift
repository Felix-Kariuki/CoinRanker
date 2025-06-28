//
//  CoinsViewModel.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import Foundation
import Combine
import TimberIOS
import SwiftData

@MainActor
class CoinsViewModel: ObservableObject{
 
    @Published var isLoading:Bool = false
    @Published var isLocalLoading:Bool = false
    @Published var errorMessage:String? = nil
    @Published var coins: [Coin] = []
    @Published var favoriteCoins: [FavoriteCoin] = []
    @Published var filters: [String] = []
    @Published var filtersStrings: [String] = []
    var sortOptions: [FilterModel] = [
        FilterModel(name:"Price", filter:"price"),
        FilterModel(name:"24h Perfomance", filter:"24hVolume")
    ]
    
     var offset: Int32 = 0
    private var limit: Int32 = 20
    private let maxLimit: Int32 = 100
    
    private var repository:CoinsRepository = CoinsRepositoryImpl()
    private var cancellables = Set<AnyCancellable>()
    var context: ModelContext?
    
    init(repository: CoinsRepository = CoinsRepositoryImpl()){
        self.repository = repository
//        fetchCoins()
    }
    
    func makeInitialCall(_ modelContext: ModelContext){
        context = modelContext
        fetchCoins()
        fetchFavorites()
    }
    
    func filterCoins() {
        coins = []
        offset = 0
        limit = 20
        filtersStrings = filters
        fetchCoins()
    }
    
    func fetchCoins() {
        guard !isLoading, offset < maxLimit else { return }
        Timber.i("FETCH COINS ..... \(isLoading) \(offset)  \(maxLimit)")
        isLoading = true

        repository.getCoins(limit: limit, offset: offset, orderBy: filters)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    Timber.e("Error fetching coins ... \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }

                self.isLoading = false
                
                self.coins.append(contentsOf: response.data.coins)

                
                self.offset += 20

                if self.offset >= self.maxLimit {
                    self.offset = self.maxLimit
                }

            })
            .store(in: &cancellables)
    }

    
    func onFilterSelect(_ filter: String) {
        if let index = filters.firstIndex(of: filter) {
            filters.remove(at: index)
        } else {
            filters.append(filter)
        }
    }

    func favouriteAction(_ modelContext: ModelContext?, coin: Coin) {
        guard let context = modelContext else { return }

        if let existingFavorite = favoriteCoins.first(where: { $0.uuid == coin.uuid }) {

            context.delete(existingFavorite)
        } else {

            let saveFavorite = coin.toFavoriteCoin()
            
            context.insert(saveFavorite)
        }

        do {
            try context.save()
            fetchFavorites()
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
            Timber.e("Failed to save/delete favorite: \(error.localizedDescription)")
        }
    }
    
    private func fetchFavorites() {
        guard let context else { return }
        isLocalLoading = true
        let descriptor = FetchDescriptor<FavoriteCoin>(sortBy: [SortDescriptor(\.timeStamp, order: .forward)])
        
        do {
            favoriteCoins = try context.fetch(descriptor)
            isLocalLoading = false
        } catch {
            Timber.e("Error fetching local coins: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            
            isLocalLoading = false
        }
    }
}

