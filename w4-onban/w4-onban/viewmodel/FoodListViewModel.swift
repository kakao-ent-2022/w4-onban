//
//  MenuViewModel.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation

protocol FoodListViewModel {
    func numberOfSections() -> Int
    func numbersOfItems(groupIndex: Int) -> Int
    func item(groupIndex: Int, itemIndex: Int) -> Food
}

class FoodListViewModelImpl: NSObject, FoodListViewModel, URLSessionDelegate {
    private var foodLists = [FoodList]()
    private enum Path: String, CaseIterable {
        case main, soup, side
    }
    
    override init() {
        super.init()
        self.foodLists = getData()
    }
    
    func numberOfSections() -> Int{
        return foodLists.count
    }
    
    func numbersOfItems(groupIndex: Int) -> Int {
        return foodLists[groupIndex].count
    }
    
    func item(groupIndex: Int, itemIndex: Int) -> Food {
        return foodLists[groupIndex][itemIndex]
    }
    
    private func getData() -> [FoodList] {
        let data: [FoodList] = Path.allCases
            .map { path in
                (try? JsonFileParser.parse(path: path.rawValue)) ?? FoodList()
            }
        return data
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let foodList = try? JSONDecoder().decode(FoodList.self, from: data)
    
    }
}
