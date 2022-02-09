//
//  ImageCacheManager.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/09.
//

import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    let fileManager = FileManager()
    private init() {}
    
    func loadImage(imageURL: String, completion: ((UIImage?) -> Void)?) {
        guard let url = URL(string: imageURL) else { return }
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(url.lastPathComponent)
        
        if fileManager.fileExists(atPath: filePath.path) {
            guard let imageData  = try? Data(contentsOf: filePath) else {
                return
            }
            let image = UIImage(data: imageData)
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
                self.fileManager.createFile(atPath: filePath.path, contents: data, attributes: nil)
                completion?(image)
            }
            downloadTask.resume()
        }
    }
}
 
