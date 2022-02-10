//
//  ApiResponse.swift
//  Onban
//
//  Created by river.o on 2022/02/10.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let statusCode: Int
    let body: T?
}
