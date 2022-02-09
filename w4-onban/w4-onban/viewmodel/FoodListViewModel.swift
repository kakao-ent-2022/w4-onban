//
//  MenuViewModel.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation
import UIKit

protocol FoodListViewModel {
    func numberOfSections() -> Int
    func numbersOfItems(groupIndex: Int) -> Int
    func item(groupIndex: Int, itemIndex: Int) -> Food
}

extension NSNotification.Name {
    static let main = NSNotification.Name("main")
    static let soup = NSNotification.Name("soup")
    static let side = NSNotification.Name("side")
}

enum FoodCategory: CaseIterable {
    case main, soup, side
    
    static func findBy(index: Int) -> FoodCategory? {
        if allCases.indices.contains(index) {
            return allCases[index]
        }
        return nil
    }
}

class FoodListViewModelImpl: NSObject, FoodListViewModel, URLSessionDelegate {
    private let repository: Repository
    private var foodLists = [FoodCategory: FoodList]()

    init(repository: Repository) {
        self.repository = repository
        super.init()
        self.getData()
    }
    
    func numberOfSections() -> Int{
        return foodLists.count
    }
    
    func numbersOfItems(groupIndex: Int) -> Int {
        let category = FoodCategory.findBy(index: groupIndex) ?? FoodCategory.main
        return foodLists[category]?.count ?? 0
    }
    
    func item(groupIndex: Int, itemIndex: Int) -> Food {
        let category = FoodCategory.findBy(index: groupIndex) ?? FoodCategory.main
        let foodList =  foodLists[category] ?? FoodList()
        return foodList[itemIndex]
    }
    
    private func getData() {
        repository.getMainFoodLists { foodList in
            self.foodLists[FoodCategory.main] = foodList
        }
        repository.getSoupFoodLists { foodList in
            self.foodLists[FoodCategory.soup] = foodList
        }
        repository.getSideFoodLists { foodList in
            self.foodLists[FoodCategory.side] = foodList
        }
    }
}
