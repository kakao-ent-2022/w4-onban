//
//  StoreItem.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/03.
//

import Foundation

struct StoreItem : Decodable, Equatable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [DeliveryType]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [Badge]?
    
    private enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case alt
        case deliveryType = "delivery_type"
        case title
        case description
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        detailHash = try container.decode(String.self, forKey: .detailHash)
        image = try container.decode(String.self, forKey: CodingKeys.image)
        alt = try container.decode(String.self, forKey: CodingKeys.alt)
        deliveryType = try container.decode([DeliveryType].self, forKey: .deliveryType)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        nPrice = try? container.decode(String.self, forKey: .nPrice)
        sPrice = try container.decode(String.self, forKey: .sPrice)
        badge = try? container.decode([Badge].self, forKey: .badge)
    }
}
