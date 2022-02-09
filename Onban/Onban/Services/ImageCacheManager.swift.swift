//
//  ImageCacheManager.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/09.
//

import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    let cache = NSCache<NSString, UIImage>()
    var keys = Set<NSString>()
    
    private init() {}
    
    func loadImage(imageURL: String, completion: ((UIImage?) -> Void)?) {
        let key = imageURL as NSString
        guard let url = URL(string: imageURL) else { return }
        if keys.contains(key) {
            let image = cache.object(forKey: key)
            completion?(image)
        } else {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let downloadTask = session.downloadTask(with: url) { url, response, error in
                guard
                    let url = url, error == nil,
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else {
                    return
                }
                self.cache.setObject(image, forKey: key)
                completion?(image)
            }
            downloadTask.resume()
        }
    }
}
 
