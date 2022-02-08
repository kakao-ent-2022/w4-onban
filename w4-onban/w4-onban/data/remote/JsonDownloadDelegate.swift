//
//  JsonLoadTaskDelegate.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/08.
//

import Foundation

class JsonDownloadDelegate: URLSessionDownloadTask, URLSessionTaskDelegate {

    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let foodList = try? JSONDecoder().decode(FoodList.self, from: data)
    
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                      didFinishDownloadingTo location: URL) {
        
        guard let sourceURL = downloadTask.originalRequest?.url else {
          return
        }
        // TODO: view update
      }
}
