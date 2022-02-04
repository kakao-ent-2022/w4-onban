//
//  FoodListViewModel.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import Foundation

struct FoodListViewModel {
    let foodsList: [FoodsViewModel]
    
    
    var numberOfSection: Int {
        return foodsList.count
    }
    
    func numberOfItemsInsection(_ section: Int) -> Int {
        return foodsList[section].count
    }
    
    func foodAtIndex(_ indexPath: IndexPath) -> FoodViewModel {
        let foods = foodsList[indexPath.section]
        return foods[indexPath.item]
    }
}
