//
//  RemoteRespositoryImpl.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

class RemoteRepositoryImple: NSObject, Repository, URLSessionDataDelegate {
    func foodDetail(hash: String, onCompletionHandler: @escaping (Result<FoodDetail, NetworkError>) -> ()) {
        networkHandler.requestFoodDetail(hash: hash, onCompletionHandler: onCompletionHandler)
    }
    
    let networkHandler = NetworkHandler.instance
    
    func mainFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ()) {
        networkHandler.requestFoodList(path: .main, onCompletionHandler: onCompletionHandler)
    }
    
    func soupFoodLists(onCompletionHandler:@escaping (Result<FoodList, NetworkError>) -> ()) {
        networkHandler.requestFoodList(path: .main, onCompletionHandler: onCompletionHandler)
    }
    
    func sideFoodLists(onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> ()) {
        networkHandler.requestFoodList(path: .main, onCompletionHandler: onCompletionHandler)
    }
}
