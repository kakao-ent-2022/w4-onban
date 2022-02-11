//
//  FoodDetailResponse.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import Foundation

struct FoodDetailResponse: Decodable {
    let hash: String
    let data: FoodDetail
    
    enum CondingKeys: String, CodingKey {
        case hash, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CondingKeys.self)
        hash = try container.decode(String.self, forKey: .hash)
        data = try container.decode(FoodDetail.self, forKey: .data)
    }
}
