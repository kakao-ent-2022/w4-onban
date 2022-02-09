//
//  EventBadgeLabel.swift
//  Onban
//
//  Created by river.o on 2022/02/09.
//

import Foundation
import UIKit

class EventBadgeLabel: UILabel {
    private var padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

    convenience init(text: String) {
        self.init()
        
        self.text = text
        font = UIFont.boldSystemFont(ofSize: 12)
        textColor = UIColor.white
        
        sizeToFit()
        
        clipsToBounds = true
        layer.cornerRadius = 5
        
        if let color = EventBadgeColor.withName(text) {
            backgroundColor = UIColor(hex: color.rawValue)
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}

enum EventBadgeColor: String, CaseIterable {
    case 이벤트특가 = "#82D32D"
    case 론칭특가 = "#86C6FF"
    
    static func withName(_ name: String) -> EventBadgeColor? {
        return self.allCases.first{ "\($0)" == name }
    }
}
