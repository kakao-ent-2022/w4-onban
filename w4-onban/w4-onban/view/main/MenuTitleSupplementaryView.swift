//
//  MenuTitleSupplementaryView.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/07.
//

import Foundation
import UIKit

class MenuTitleSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = "menu-title-supplementary-reuse-identifier"
    
    private let horizontalInset = CGFloat(16)
    private let verticalInset = CGFloat(16)
    
    private let label: UILabel = {
        $0.font = OnbanFontStyle.bold.font(size: 22)
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func set(content: String) {
        label.text = content
    }
    
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: verticalInset),
        ])
    }
}
