//
//  LocalRepositoryImpl.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

struct LocalRepositoryImpl: Repository {
    private enum Path: String, CaseIterable {
        case main, soup, side
    }
    
    func getSoupFoodLists(onCompletionHandler: @escaping (FoodList?) -> ()) {
        let data: FoodList? = try? JsonFileParser.parse(path: Path.soup.rawValue)
        onCompletionHandler(data)
    }
    
    func getSideFoodLists(onCompletionHandler: @escaping (FoodList?) -> ()) {
        let data: FoodList? = try? JsonFileParser.parse(path: Path.side.rawValue)
        onCompletionHandler(data)
    }
    
    func getMainFoodLists(onCompletionHandler: @escaping (FoodList?) -> ()) {
        let data: FoodList? = try? JsonFileParser.parse(path: Path.main.rawValue)
        onCompletionHandler(data)
    }
}
