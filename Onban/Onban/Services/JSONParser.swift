//
//  JSONParser.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import UIKit

enum JSONParserError: Error {
    case invalidURL
    case failedToDecode
}

struct JSONLoader {
    static func load<T: Decodable>(from urlString: String, to type: T.Type,  completion: @escaping (Result<T, JSONParserError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(T.self, from: data) else {
                completion(.failure(.failedToDecode))
                return
            }
            completion(.success(result))
        }.resume()
    }
}
