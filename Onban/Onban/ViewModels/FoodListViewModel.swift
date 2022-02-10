//
//  FoodListViewModel.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import Foundation

class FoodListViewModel {
    var foodsList: [FoodsViewModel]
    
    init(foodsList: [FoodsViewModel]) {
        self.foodsList = foodsList
    }
    
    func addFoodViewModel(type: FoodsType, completion: ( () -> Void)? = nil) {
        let url = type.JSONURL

        JSONLoader.load(from: url, to: FoodResponse.self) { result in
            switch result{
            case .success(let foodResponse):
                let foodVM = FoodsViewModel(type: .main, foods: foodResponse.body)
                self.foodsList.append(foodVM)
                completion?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
    
    func titleOfSection(_ section: Int) -> String {
        switch section {
        case 0:
            return FoodsType.main.headerTitle
        case 1:
            return FoodsType.soup.headerTitle
        case 2:
            return FoodsType.side.headerTitle
        default:
            return ""
        }
    }
}
