//
//  JsonParser.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/04.
//

import Foundation

enum JsonParseError: Error {
    case pathError
    case typeError
    case fileContentIsEmpty
}

class JsonFileParser {
    
    static func parse<T>(path: String) throws -> T where T: Decodable{
        guard let path = Bundle.main.path(forResource: path, ofType: "json")
        else {
            throw JsonParseError.pathError
        }
        
        guard let jsonString = try? String(contentsOfFile: path)
        else {
            throw JsonParseError.fileContentIsEmpty
        }
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        
        if let data = data,
            let result = try? decoder.decode(T.self, from: data)
        { return result }
        
        throw JsonParseError.typeError
    }
}
