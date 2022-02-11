//
//  FoodDetail.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import Foundation

struct FoodDetail: Decodable {
    let topImage: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSectionImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSectionImages = "detail_section"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        topImage = try container.decode(String.self, forKey: .topImage)
        thumbImages = try container.decode([String].self, forKey: .thumbImages)
        productDescription = try container.decode(String.self, forKey: .productDescription)
        point = try container.decode(String.self, forKey: .point)
        deliveryInfo = try container.decode(String.self, forKey: .deliveryInfo)
        deliveryFee = try container.decode(String.self, forKey: .deliveryFee)
        prices = try container.decode([String].self, forKey: .prices)
        detailSectionImages = try container.decode([String].self, forKey: .detailSectionImages)
    }
}
