//
//  Respository.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

protocol Repository {
    func getMainFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ())
    
    func getSoupFoodLists(onCompletionHandler:@escaping (Result<FoodList, NetworkError>) -> ())
    
    func getSideFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ())
}
