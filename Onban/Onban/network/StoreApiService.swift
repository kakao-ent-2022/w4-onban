//
//  StoreApiService.swift
//  Onban
//
//  Created by river.o on 2022/02/10.
//

import Foundation

class StoreApiService {
    
    enum ApiError: LocalizedError {
        case urlNotSupport
        case noData
        
        var errorDescription: String? {
            switch self {
            case .urlNotSupport: return "URL Not Supported"
            case .noData: return "Has no data"
            }
        }
    }
    
    static let shared: StoreApiService = StoreApiService()
    
    private let baseUrl = "https://api.codesquad.kr/onban/"
    private let defaultSession = URLSession(configuration: .default)

    func getStores(
        resource: String,
        completionHandler: @escaping (Result<[StoreItem], ApiError>) -> Void
    ) {
        guard let url = URL(string: "\(baseUrl)\(resource)") else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
                
        let request = URLRequest(url: url)
        
        defaultSession.load(urlRequest: request) { (data: [StoreItem]?, isSuccess: Bool) in
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
    }
}
