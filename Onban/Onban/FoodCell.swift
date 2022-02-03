//
//  SideDishCell.swift
//  Onban
//
//  Created by terry.yes on 2022/02/03.
//

import UIKit

class FoodCell: UICollectionViewCell {
    let foodImage: UIImageView = UIImageView(image: UIImage(named: "foodThumbnail.png"))
    let eventTagImage: UIImageView = UIImageView(image: UIImage(named: "eventTag.png"))
    let newTagImage: UIImageView = UIImageView(image: UIImage(named: "newTag.png"))
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    let currentPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    let originalPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentPrice, originalPrice])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private lazy var tagStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventTagImage, newTagImage])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel, priceStackView, tagStackView])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodImage, informationStackView])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    func configure(title: String) {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        titleLabel.text = title
        detailLabel.text = "body"
        currentPrice.text = "5,200원"
        originalPrice.text = "6,500원"
        
    }
    
}

