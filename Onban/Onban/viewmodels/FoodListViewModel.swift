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
}

class FoodListViewModelImpl: FoodListViewModel {
    private var datas: [[Food]] = []
    private enum Path: String, CaseIterable {
        case main, soup, side
    }
    
    init() {
        for path in Path.allCases {
            let data = (try? getData(from: path.rawValue)) ?? []
            datas.append(data)
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return datas[section].count
    }
    
    func numberOfSections() -> Int {
        return datas.count
    }
    
    func get(section: Int, row: Int) -> Food {
        return datas[section][row]
    }
    
    private func getData(from path: String) throws -> [Food]? {
        guard let path = Bundle.main.path(forResource: path, ofType: "json"),
              let jsonString = try? String(contentsOfFile: path) else {
                  throw CommonError.JSON_PARSING_ERROR
              }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        
        if let data = data, let result = try? decoder.decode([Food].self, from: data) {
            return result
        }
        throw CommonError.JSON_PARSING_ERROR
    }
    
}
