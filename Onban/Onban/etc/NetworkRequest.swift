//
//  NetworkRequest.swift
//  Onban
//
//  Created by lauren.c on 2022/02/07.
//

import Foundation

struct NetworkRequest {
    
    func getSessionManager(delegate: URLSessionDelegate?) -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        return SessionManager(session: session)
    }
}

class SessionManager {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    func getDataTask(with url: URL, networkErrorHandler: ((Error) -> Void)?, responseErrorHandler: ((URLResponse?) -> Void)?, completionHandler: @escaping (Data?) -> Void) -> URLSessionTask {
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
    
    func getDataTask(with url: URL, completionHandler: @escaping (Data?) -> Void) -> URLSessionTask {
        getDataTask(with: url, networkErrorHandler: nil, responseErrorHandler: nil, completionHandler: completionHandler)
    }
    
    func getDownloadTask(with url: URL, completionHandler: @escaping (URL?) -> Void) -> URLSessionDownloadTask {
        return session.downloadTask(with: url, completionHandler: { (url, response, error) in
            if let _ = error {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      return
                  }
            completionHandler(url)
        })
    }
}
