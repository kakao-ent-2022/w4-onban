//
//  ItemHeaderView.swift
//  Onban
//
//  Created by terry.yes on 2022/02/03.
//

import UIKit

class FoodHeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        return label
    }()
    
    func configure(title: String) {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        titleLabel.text = title
    }
}
