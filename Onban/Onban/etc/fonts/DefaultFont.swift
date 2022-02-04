//
//  DefaultFont.swift
//  Onban
//
//  Created by lauren.c on 2022/02/04.
//

import UIKit

enum DefaultFonts: String {
    case sansLight = "NotoSansKR-Light"
    case sansMedium =  "NotoSansKR-Medium"
    case sansBold = "NotoSansKR-Bold"
}

func defaultFont(_ name: DefaultFonts, size: CGFloat) -> UIFont? {
    return UIFont(name: name.rawValue, size: size)
}
