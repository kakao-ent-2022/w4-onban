//
//  ImageDownloader.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import Foundation

enum ImageLoadError: Error {
    case url
    case network
    case cacheFail
}

class ImageLoader {
    let urlSession = URLSession(configuration: .default)
    
    func load(from: String, completionHandler: @escaping (Result<Data, ImageLoadError>) -> Void) {
        guard let url = URL(string: from) else {
            completionHandler(.failure(.url))
            return
        }
        
        if let data = ImageCacheManager.instance.load(fileName: from) {
            completionHandler(.success(data))
        }
    
        let task = urlSession.downloadTask(with: url) { location, urlResponse, error in
            guard let response = urlResponse as? HTTPURLResponse,
                  let location = location,
                response.statusCode == 200
            else {
                completionHandler(.failure(.network))
                return
            }
            
            guard let imageData = try? Data(contentsOf: location),
                  ImageCacheManager.instance.cache(fileName: location.path, data: imageData)
            else {
                completionHandler(.failure(.cacheFail))
                return
            }
            
            completionHandler(.success(imageData))
        }
        
        task.resume()
    }
}
