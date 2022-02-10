//
//  DetailFoodData.swift
//  Onban
//
//  Created by terry.yes on 2022/02/10.
//

import Foundation

struct FoodDescriptionData: Decodable {
    let hash: String
    let data: FoodDescription
}

struct FoodDescription: Decodable {
    let topImage: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]
    
    private enum CodingKeys: String, CodingKey {
        
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
}
