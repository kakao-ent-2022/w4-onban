//
//  FoodDetail.swift
//  Onban
//
//  Created by lauren.c on 2022/02/09.
//

struct FoodDetail: Decodable {
    let topImage: String
    let thumbnails: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]
    
    private enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbnails = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    
    }
    
}
