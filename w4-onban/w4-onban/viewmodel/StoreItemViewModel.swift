//
//  MenuViewModel.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation

class StoreItemViewModel {
    private let storeItemGroups: [StoreItemGroup]
    
    init(itemGroups: [StoreItemGroup]) {
        self.storeItemGroups = itemGroups
    }
    
    func numberOfSections() -> Int{
        return storeItemGroups.count
    }
    
    func numbersOfItem(groupIndex: Int) -> Int {
        return storeItemGroups[groupIndex].count
    }
    
    func item(groupIndex: Int, itemIndex: Int) -> StoreItem {
        return storeItemGroups[groupIndex][itemIndex]
    }
}
