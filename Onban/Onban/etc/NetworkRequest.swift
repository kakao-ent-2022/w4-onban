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
    
    func getDataTask(with url: URL, from session: URLSession, networkErrorHandler: ((Error) -> Void)?, responseErrorHandler: ((URLResponse?) -> Void)?, completionHandler: @escaping (Data?) -> Void ) -> URLSessionTask {
        return session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                networkErrorHandler?(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      responseErrorHandler?(response)
                      return
                  }
            completionHandler(data)
        }
    }
    
    func getDataTask(with url: URL, from session: URLSession, completionHandler: @escaping (Data?) -> Void) -> URLSessionTask {
        getDataTask(with: url, from: session, networkErrorHandler: nil, responseErrorHandler: nil, completionHandler: completionHandler)
    }
    
}
