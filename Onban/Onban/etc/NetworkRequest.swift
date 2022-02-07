//
//  NetworkRequest.swift
//  Onban
//
//  Created by lauren.c on 2022/02/07.
//

import Foundation

struct NetworkRequest {
    func getSession(delegate: URLSessionDataDelegate?) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
    
}
