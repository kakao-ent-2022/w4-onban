//
//  StoreCollectionViewCell.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation
import UIKit

class StoreCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let storeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .basicText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .descriptionText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let finalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .basicText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previousPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .cancleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventBadgeContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func addViews() {
        addSubview(storeImageView)
        addSubview(storeTitleLabel)
        addSubview(storeDescriptionLabel)
        addSubview(finalPriceLabel)
        addSubview(previousPriceLabel)
        addSubview(eventBadgeContainer)
        
        storeImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        storeImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        storeImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        storeImageView.widthAnchor.constraint(equalTo: storeImageView.heightAnchor, multiplier: 1/1).isActive = true
        
        storeTitleLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 10).isActive = true
        storeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        storeTitleLabel.topAnchor.constraint(lessThanOrEqualTo: storeImageView.topAnchor, constant: 8).isActive = true
        
        storeDescriptionLabel.topAnchor.constraint(equalTo: storeTitleLabel.bottomAnchor, constant: 4).isActive = true
        storeDescriptionLabel.leadingAnchor.constraint(equalTo: storeTitleLabel.leadingAnchor).isActive = true
        storeDescriptionLabel.trailingAnchor.constraint(equalTo: storeTitleLabel.trailingAnchor).isActive = true
        
        finalPriceLabel.topAnchor.constraint(equalTo: storeDescriptionLabel.bottomAnchor, constant: 8).isActive = true
        finalPriceLabel.leadingAnchor.constraint(equalTo: storeTitleLabel.leadingAnchor).isActive = true
        
        previousPriceLabel.leadingAnchor.constraint(equalTo: finalPriceLabel.trailingAnchor, constant: 4).isActive = true
        previousPriceLabel.topAnchor.constraint(equalTo: finalPriceLabel.topAnchor).isActive = true
        
        eventBadgeContainer.topAnchor.constraint(equalTo: finalPriceLabel.bottomAnchor, constant: 8).isActive = true
        eventBadgeContainer.leadingAnchor.constraint(equalTo: storeTitleLabel.leadingAnchor).isActive = true
        eventBadgeContainer.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func bind(store: StoreItem) {
        guard let imageUrl = URL(string: store.image) else {
            return
        }
        if let imageData = try? Data(contentsOf: imageUrl) {
            storeImageView.image = UIImage(data: imageData)
        }
        
        storeTitleLabel.text = store.title
        storeDescriptionLabel.text = store.description
        finalPriceLabel.text = store.sPrice
        
        if let nPrice = store.nPrice {
            previousPriceLabel.isHidden = false
            previousPriceLabel.attributedText = "\(nPrice)원".strikeThrough()
        } else {
            previousPriceLabel.isHidden = true
        }
        
        eventBadgeContainer.subviews.forEach({ $0.removeFromSuperview() })
        if let events = store.badge {
            for event in events {
                let eventBadgeLabel = EventBadgeLabel(text: event)
                eventBadgeContainer.addArrangedSubview(eventBadgeLabel)
            }
        }
    }
}
