//
//  JSONParser.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import UIKit

enum JSONParserError: Error {
    case invalidName
    case failedToDecode
}

struct JSONParser {
    private static func loadAsset(for name: String) -> NSDataAsset? {
        return NSDataAsset(name: name)
    }
    
    private static func decodeAsset<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
    
    static func load<T: Decodable>(from name: String, to type: T.Type, completion: (Result<T, JSONParserError>) -> Void) {
        guard let asset = loadAsset(for: name) else {
            completion(.failure(.invalidName))
            return
        }
        guard let result = decodeAsset(type: type, from: asset.data) else {
            completion(.failure(.failedToDecode))
            return
        }
        completion(.success(result))
    }
}

struct JSONLoader {
    static func load<T: Decodable>(from urlString: String, to type: T.Type,  completion: @escaping (Result<T, JSONParserError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let result = try! decoder.decode(T.self, from: data)
            completion(.success(result))
        }.resume()
    }
}
