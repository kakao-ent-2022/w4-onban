//
//  NetworkHandler.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation


enum NetworkError: Error {
    case url
    case paramsError
    case duplicateId
    case parseError
    case unknown
}

fileprivate let baseUrl = "https://api.codesquad.kr/onban/"

enum Path: String {
    case main, soup, side
}

enum NetworkConstant {
    static let signUpUrl = "https://api.codesquad.kr/signup"
}

enum RequestMethod: String {
    case post = "POST"
}

class NetworkHandler {
    
    var urlComponents = URLComponents(string: baseUrl)
    static let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    class func request(path: Path, delegate: URLSessionTaskDelegate)  throws {
        guard let url = URL(string: baseUrl + path.rawValue) else {
            throw NetworkError.url
        }
        
        let task = defaultSession.dataTask(with: url)
        
        task.delegate = delegate
        task.resume()
    }
    
    private static func getRequest(path: Path, method: RequestMethod, body: Data?) throws -> URLRequest {
        let resourceUrl = baseUrl + path.rawValue
        
        guard let url = URL(string: resourceUrl) else{
            print("URL is null")
            throw NetworkError.url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post.rawValue
        request.httpBody = body
        return request
    }
}
