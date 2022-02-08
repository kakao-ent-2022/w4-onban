//
//  BadgeLabel.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/07.
//

import Foundation
import UIKit

class BadgeLabel: UILabel {
    private let inset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    var rightInset: CGFloat {
        return inset.right
    }
    var leftInset: CGFloat {
        return inset.left
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += inset.left + inset.right
        intrinsicContentSize.height += inset.top + inset.bottom
        return intrinsicContentSize
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    
    convenience init(badge: Badge) {
        self.init(frame: CGRect.zero)
        text = badge.rawValue
        backgroundColor = backgroundColorBy(badge: badge)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUi()
    }
    
    private func initUi() {
        font = UIFont(onbanStyle: .regular, size: 12)
        
        textColor = UIColor(onbanColor: .badgeText)
        textAlignment = NSTextAlignment.center
        
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
    private func backgroundColorBy(badge: Badge) -> UIColor? {
        switch(badge) {
        case .event:
            return UIColor(onbanColor: .eventBadge)
        case .launchEvent:
            return UIColor(onbanColor: .launchEventBadge)
        }
    }
}
