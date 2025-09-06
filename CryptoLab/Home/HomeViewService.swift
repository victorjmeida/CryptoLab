//
//  HomeViewService.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 03/09/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case transport(Error)
    case invalidResponse
    case badStatus(Int)
    case decoding(Error)
}

protocol CoinGeckoServiceProtocol {
    func fetchMarkets(
        vsCurrency: String,
        page: Int,
        perPage: Int,
        completion: @escaping (Result<[CoinMarket], APIError>) -> Void
    )
}
 
final class CoinGeckoService: CoinGeckoServiceProtocol {
    private let base = "https://api.coingecko.com/api/v3"

    func fetchMarkets(
        vsCurrency: String = "usd",
        page: Int = 1,
        perPage: Int = 50,
        completion: @escaping (Result<[CoinMarket], APIError>) -> Void
    ) {
        var comps = URLComponents(string: base + "/coins/markets")
        comps?.queryItems = [
            .init(name: "vs_currency", value: vsCurrency),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "\(perPage)"),
            .init(name: "page", value: "\(page)"),
            .init(name: "sparkline", value: "false"),
            .init(name: "price_change_percentage", value: "24h")
        ]
        guard let url = comps?.url else { completion(.failure(.invalidURL)); return }

        let req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
        URLSession.shared.dataTask(with: req) { data, resp, err in
            if let err = err { completion(.failure(.transport(err))); return }
            guard let http = resp as? HTTPURLResponse else { completion(.failure(.invalidResponse)); return }
            guard (200..<300).contains(http.statusCode) else { completion(.failure(.badStatus(http.statusCode))); return }
            guard let data = data else { completion(.failure(.invalidResponse)); return }
            do {
                let coins = try JSONDecoder().decode([CoinMarket].self, from: data)
                completion(.success(coins))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }.resume()
    }
}
