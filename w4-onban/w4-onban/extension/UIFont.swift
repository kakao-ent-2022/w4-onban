//
//  UIFont.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/07.
//

import Foundation
import UIKit

enum OnbanFontStyle: String {
    case bold = "NotoSansKR-Bold"
    case regular = "NotoSansKR-Regular"
    
    func font(size: CGFloat) -> UIFont? {
        return UIFont(name: self.rawValue, size: size)
    }
}
