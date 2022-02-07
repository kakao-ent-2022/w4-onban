//
//  Color.swift
//  Onban
//
//  Created by lauren.c on 2022/02/04.
//

import UIKit



enum DefaultColors: String {
    case lightGray = "defaultLightGray"
    case font = "defaultMainFont"
    case background = "defaultBackground"
    case subFont = "defaultSubFont"
    case darkerFont = "defaultDarkerFont"
    case darkerBackground = "defaultDarkerBackground"
    case green, lightBlue
}

func defaultColor(_ name: DefaultColors) -> UIColor? {
    return UIColor(named: name.rawValue)
}
