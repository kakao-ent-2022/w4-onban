//
//  Respository.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

protocol Repository {
    func getMainFoodLists(onCompletionHandler: @escaping (FoodList?) -> ())
    func getSoupFoodLists(onCompletionHandler: @escaping (FoodList?) -> ())
    func getSideFoodLists(onCompletionHandler: @escaping (FoodList?) -> ())
}
