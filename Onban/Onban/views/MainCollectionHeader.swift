//
//  MainCollectionHeader.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class MainCollectionHeader: UICollectionReusableView {
    private let defaultMargin: CGFloat = 18
    static let height: CGFloat = fontSize + 24
    static let fontSize: CGFloat = 22
    var title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NotoSansKR-Medium", size: fontSize)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: defaultMargin),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: defaultMargin),
            title.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
