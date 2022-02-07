//
//  FoodListViewModel.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import Foundation

protocol FoodListViewModel {
    func numberOfRowsInSection(_: Int) -> Int
    func numberOfSections() -> Int
    func get(section: Int, row: Int) -> Food
    func insert(data: [Food], at: Int)
    func get(section: Int) -> [Food]
}

class FoodListViewModelImpl: FoodListViewModel {
    private var datas: [[Food]] = [[],[],[]]
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return datas[section].count
    }
    
    func numberOfSections() -> Int {
        return datas.count
    }
    
    func get(section: Int, row: Int) -> Food {
        return datas[section][row]
    }
    
    func insert(data: [Food], at section: Int) {
        datas[section] = data
    }
    func get(section: Int) -> [Food] {
        return datas[section]
    }
    
}
