//
//  StoreItemList.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation

struct StoreItemGroup: Decodable {
    private var items: [StoreItem]
    
    subscript(index: Int) -> StoreItem {
        get {
            return items[index]
        }
    }
    
    var count: Int {
        return items.count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([StoreItem].self)
    }
}
