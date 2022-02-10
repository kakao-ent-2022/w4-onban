//
//  NetworkHandler.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation
import UIKit


enum NetworkError: Error {
    case url
    case paramsError
    case parseError
    case unknown
}

enum Path: String, CaseIterable {
    case main, soup, side
    
    static func findBy(rawValue: String) -> Path? {
        return self.allCases
            .first { $0.rawValue == rawValue }
    }
}

class NetworkHandler: NSObject, URLSessionDelegate {
    static let instance: NetworkHandler = NetworkHandler()
    private override init() {}
    
    
    var baseUrl = URL(string: "https://api.codesquad.kr/onban/")
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func requestFoodList(path: Path, onCompletionHandler: @escaping (Result<FoodList, NetworkError>) -> Void)  {
        guard let url = baseUrl?.appendingPathComponent(path.rawValue) else {
            onCompletionHandler(.failure(.url))
            print("load fail")
            return
        }
        
        defaultSession.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let response = try? JSONDecoder().decode(Response<FoodList>.self, from: data)
            else {
                onCompletionHandler(.failure(.parseError))
                print("load fail")
                return
            }
            
            let foodList = response.body
            onCompletionHandler(.success(foodList))
            print("load sucess")
        }.resume()
    }
}
