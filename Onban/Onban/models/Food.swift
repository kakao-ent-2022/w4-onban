//
//  Food.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//


struct Food: Codable {
    let id: String
    let title: String
    let imagePath: String
    let delivery_type: [String]
    let description: String
    let originalPrice: String?
    let actualPrice: String
    let badge: [String] = []
    
    private enum CodingKeys: String, CodingKey {
        case id = "detail_hash"
        case imagePath = "image"
        case title, delivery_type, description, badge
        case originalPrice = "n_price"
        case actualPrice = "s_price"
    }
    
}
