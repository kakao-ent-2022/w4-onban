//
//  Respository.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

protocol Repository {
    func mainFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ())
    
    func soupFoodLists(onCompletionHandler:@escaping (Result<FoodList, NetworkError>) -> ())
    
    func sideFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ())
    
    func foodDetail(hash: String,onCompletionHandler: @escaping (Result<FoodDetail, NetworkError>) -> ())
}
