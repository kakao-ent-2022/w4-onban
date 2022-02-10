//
//  StoreItem.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/03.
//

import Foundation

struct Food : Decodable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [DeliveryType]
    let title: String
    let description: String
    let beforeSalePrice: String?
    let salePrice: String
    private let badge: [Badge]
    
    var hashEventBadge: Bool {
        return badge.first { $0 == Badge.event } != nil
    }
    
    var hasLaunchEvent: Bool {
        return badge.first { $0 == Badge.launchEvent } != nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case alt
        case deliveryType = "delivery_type"
        case title
        case description
        case beforeSalePrice = "n_price"
        case salePrice = "s_price"
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
        beforeSalePrice = try? container.decode(String.self, forKey: .beforeSalePrice)
        salePrice = try container.decode(String.self, forKey: .salePrice)
        badge = (try? container.decode([Badge].self, forKey: .badge)) ?? []
    }
}
