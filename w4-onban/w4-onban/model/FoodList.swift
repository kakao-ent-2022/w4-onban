//
//  StoreItemList.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation

struct FoodList: Decodable {
    private var items: [Food]
    
    subscript(index: Int) -> Food {
        get {
            return items[index]
        }
    }
    
    var count: Int {
        return items.count
    }
    
    init() {
        items = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([Food].self)
    }
}
