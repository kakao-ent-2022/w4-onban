//
//  StoreItemList.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation

struct StoreItemGroup {
    private let items: Array<StoreItem>
    
    subscript(index: Int) -> StoreItem {
        get {
            return items[index]
        }
    }
    
    var count: Int {
        return items.count
    }
}
