//
//  FoodViewModel.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import UIKit

struct FoodViewModel {
    let food: Food
    
    var title: String { food.title }
    var description: String { food.description}
    var nPrice: String? { food.nPrice }
    var sPrice: String { food.sPrice }
}

enum FoodsType {
    case main
    case side
    case soup
}

struct FoodsViewModel {
    let type: FoodsType
    let foods: [Food]
    var count: Int {
        return foods.count
    }
    
    subscript(index: Int) -> FoodViewModel {
        return FoodViewModel(food: foods[index])
    }
}
