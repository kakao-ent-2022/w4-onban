//
//  MainCollectionHeader.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class MainCollectionHeader: UICollectionReusableView {
    private static let horizontalMargin: CGFloat = 18
    private static let verticalMargin: CGFloat = 24
    private static let fontSize: CGFloat = 22
    static var height: CGFloat = fontSize + verticalMargin * 2
    
    var title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = defaultFont(.sansBold, size: fontSize)
        label.textColor = defaultColor(.font)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: MainCollectionHeader.horizontalMargin),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: MainCollectionHeader.horizontalMargin)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
