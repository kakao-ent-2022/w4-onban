//
//  RemoteRespositoryImpl.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

class RemoteRepositoryImple: NSObject, Repository, URLSessionDataDelegate {
    let networkHandler = NetworkHandler.instance
    
    func getMainFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ()) {
        networkHandler.requestFoodList(path: .main, onCompletionHandler: onCompletionHandler)
    }
    
    func getSoupFoodLists(onCompletionHandler:@escaping (Result<FoodList, NetworkError>) -> ()) {
        networkHandler.requestFoodList(path: .main, onCompletionHandler: onCompletionHandler)
    }
    
    func getSideFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ()) {
        networkHandler.requestFoodList(path: .main, onCompletionHandler: onCompletionHandler)
    }
}
