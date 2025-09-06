//
//  HomeModel.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 03/09/25.
//

import Foundation

//Representa a moeda
struct CoinMarket: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String?
    let currentPrice: Double
    let priceChangePercentage24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
