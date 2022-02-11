//
//  ImageCacheManager.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import Foundation

class ImageCacheManager {
    static let instance = ImageCacheManager()
    
    let fileManager = FileManager.default
    
    var cacheDirectory: URL {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
            .first!
    }
    
    private init() {}
    
    func cache(fileName: String, data: Data) -> Bool {
        guard let url = URL(string: fileName) else { return false}
        
        
        let fileUrl = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        let filePath = fileUrl.path
        if !fileManager.fileExists(atPath: filePath) {
            let isSuccess = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
            return isSuccess
        }
        return false
    }
    
    func load(fileName: String) -> Data? {
        guard let url = URL(string: fileName) else { return nil }
        
        let fileUrl = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        let filePath = fileUrl.path
        
        if fileManager.fileExists(atPath: filePath) {
            if let imageData = try? Data(contentsOf: fileUrl)  {
                return imageData
            }
            return nil
        }
        return nil
    }
}
