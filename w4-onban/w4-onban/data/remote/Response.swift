//
//  Response.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/09.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    var statusCode: Int
    var body: T
    
    private enum CodingKeys: String, CodingKey {
        case statusCode, body
    }
    
    init(statusCode: Int, body: T) {
        self.statusCode = statusCode
        self.body = body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
        body = try container.decode(T.self, forKey: .body)
    }
}
