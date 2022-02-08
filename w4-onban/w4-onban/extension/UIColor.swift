//
//  UIColor.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/07.
//

import Foundation
import UIKit

enum OnBanColor: String {
    case eventBadge
    case launchEventBadge
    case badgeText
    case descriptionText
    case priceBeforeSale
}
extension UIColor {
    convenience init?(onbanColor: OnBanColor) {
        self.init(named: onbanColor.rawValue)
    }
}
