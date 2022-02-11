//
//  StoreItem.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation

struct StoreItem: Decodable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image = "image"
        case alt = "alt"
        case deliveryType = "delivery_type"
        case title = "title"
        case description = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge = "badge"
    }
}
