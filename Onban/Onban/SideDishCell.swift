//
//  SideDishCell.swift
//  Onban
//
//  Created by terry.yes on 2022/02/03.
//

import UIKit

class SideDishCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    func configure(title: String) {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        titleLabel.text = title
    }
    
}
