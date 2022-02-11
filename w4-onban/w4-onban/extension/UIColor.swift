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
    case divider
    case metaData
    case orderButton
    
    var color: UIColor? {
        return UIColor(named: self.rawValue)
    }
}
