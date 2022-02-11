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
}
