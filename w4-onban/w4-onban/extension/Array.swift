//
//  Array.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/07.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
