//
//  Food.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/03.
//

import Foundation

struct Food: Decodable {
    let hashID: String
    let imageURL: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badges: [String]?

    private enum CodingKeys: String, CodingKey {
        case hashID = "detail_hash"
        case imageURL = "image"
        case alt
        case deliveryType = "delivery_type"
        case title
        case description
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badges = "badge"
    }
}

//struct Food: Decodable {
//
//    let hashId: String
//    let imageURL: String
//    let alt: String
//    let deliveryType: [String]
//    let title: String
//    let description: String
//    let normalPrice: String?
//    let specialPrice: String
//    let badge: [String]?
//
//
//    private enum CodingKeys: String, CodingKey {
//        case hashId = "detail_hash"
//        case imageURL = "image"
//        case alt
//        case deliveryType = "delivery_type"
//        case title
//        case description
//        case normalPrice = "n_price"
//        case specialPrice = "s_price"
//        case badge
//    }
//}
