//
//  FoodListViewModel.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import Foundation

enum HeaderTitle {
    static let main = "메인반찬 / 한그릇 뚝딱 메인 요리"
    static let soup = "국.찌게 / 김이 모락모락 국.찌게"
    static let side = "밑반찬 / 언제 먹어도 든든한 밑반찬"
}
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
    
    func titleOfSection(_ section: Int) -> String {
        switch section {
        case 0:
            return HeaderTitle.main
        case 1:
            return HeaderTitle.soup
        case 2:
            return HeaderTitle.side
        default:
            return ""
        }
    }
}
