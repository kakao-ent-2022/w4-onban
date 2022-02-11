//
//  RemoteRespositoryImpl.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

class RemoteRepositoryImpl: NSObject, Repository, URLSessionDataDelegate {
    
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
    
    func foodDetailImages(imageUrls: [String], onCompletionHandler: @escaping (Result<[Data], NetworkError>) -> ()) {
        let dispatchGroup = DispatchGroup()
        var foodDetailImages = [Data]()
        
        imageUrls.forEach { url in
            dispatchGroup.enter()
            
            ImageLoader.instance.load(from: url) { result in
                switch result {
                    
                case .success(let data):
                    foodDetailImages.append(data)
                    dispatchGroup.leave()
                    
                case .failure(_):
                    dispatchGroup.leave()
                    dispatchGroup.notify(queue: .main) {
                        onCompletionHandler(.failure(.parseError))
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            onCompletionHandler(.success(foodDetailImages))
        }
    }
}
