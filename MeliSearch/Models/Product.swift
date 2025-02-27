//
//  Product.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import Foundation


struct SearchResponse: Codable {
    let results: [Product]
}


struct Product: Codable, Identifiable {
    let id: String
    let title: String
    let price: Double
    let currencyID: String
    let availableQuantity: Int
    let thumbnail: String
    let condition: String
    let permalink: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case thumbnail
        case condition
        case permalink
    }
}

