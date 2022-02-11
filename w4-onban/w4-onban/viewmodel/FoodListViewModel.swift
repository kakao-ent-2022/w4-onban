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
    func item(groupIndex: Int, itemIndex: Int) -> Food?
    func addMainObserver(observer: Any, selector: Selector)
    func addSideObserver(observer: Any, selector: Selector)
    func addSoupObserver(observer: Any, selector: Selector)
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
    let notificationCenter = NotificationCenter()
    
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
    
    func item(groupIndex: Int, itemIndex: Int) -> Food? {
        let category = FoodCategory.findBy(index: groupIndex) ?? FoodCategory.main
        let foodList =  foodLists[category] ?? FoodList()
        return foodList[itemIndex]
    }
    
    private func getData() {
        repository.mainFoodLists { result in
            switch result{
            case .success(_):
                self.foodLists[FoodCategory.main] = try? result.get()
                self.notificationCenter.post(name: .main, object: self)
            case .failure(_):
                // TODO: show error view
                print("load main fail")
                break
            }
        }
        repository.soupFoodLists { result in
            switch result{
            case .success(_):
                self.foodLists[FoodCategory.soup] = try? result.get()
                self.notificationCenter.post(name: .main, object: self)
            case .failure(_):
                // TODO: show error view
                print("load soup fail")
                break
            }
        }
        repository.sideFoodLists { result in
            switch result{
            case .success(_):
                self.foodLists[FoodCategory.side] = try? result.get()
                self.notificationCenter.post(name: .main, object: self)
            case .failure(_):
                // TODO: show error view
                print("load soup fail")
                break
            }
        }
    }
    
    func addMainObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: .main, object: self)
    }
    
    func addSideObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: .side, object: self)
    }
    
    func addSoupObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: .soup, object: self)
    }
}
