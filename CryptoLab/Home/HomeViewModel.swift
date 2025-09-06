//
//  HomeViewModel.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 08/07/25.
//

import Foundation

final class HomeViewModel {
    private let service: CoinGeckoServiceProtocol

    // estados expostos pra VC
    private(set) var coins: [CoinMarket] = []
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?

    init(service: CoinGeckoServiceProtocol = CoinGeckoService()) {
        self.service = service
    }

    func load(page: Int = 1, perPage: Int = 50, completion: @escaping () -> Void) {
        isLoading = true
        errorMessage = nil

        service.fetchMarkets(vsCurrency: "usd", page: page, perPage: perPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.coins = data
                case .failure(let err):
                    self.errorMessage = "\(err)"
                    self.coins = []
                }
                completion()
            }
        }
    }
}
