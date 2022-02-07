//
//  MainCollectionCell.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class FoodListCollectionCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = defaultFont(.sansBold, size: 14)
        label.textColor = defaultColor(.font)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = defaultColor(.subFont)
        label.font = defaultFont(.sansLight, size: 14)
        return label
    }()
    let actualPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = defaultColor(.darkerFont)
        label.font = defaultFont(.sansBold, size: 14)
        return label
    }()
    let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = defaultColor(.lightGray)
        label.font = defaultFont(.sansMedium, size: 14)
        return label
    }()
    var badge1: UILabel = {
        let label = BadgeLabel()
        return label
    }()
    var badge2: UILabel = {
        let label = BadgeLabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func configure(from model: Food) {
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
        self.actualPriceLabel.text = model.actualPrice
        if var originalPrice = model.originalPrice {
            if originalPrice.last != "원" {
                originalPrice += "원"
            }
            self.originalPriceLabel.attributedText = NSAttributedString.init(string: originalPrice, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        }
        self.imageView.image = UIImage(named: "loading-food-list")
        
        guard let badge1 = model.badge.first(where: { $0 == .event }) ?? model.badge.first(where: { $0 == .launch }) else {
            self.badge1.isHidden = true
            self.badge2.isHidden = true
            return
        }
        self.badge1.isHidden = false
        self.badge1.backgroundColor = badge1 == .event ? defaultColor(.green) : defaultColor(.lightBlue)
        self.badge1.text = badge1.rawValue
        
        if let badge2 = model.badge.first(where: { $0 == .launch }), badge1 == .event {
            self.badge2.isHidden = false
            self.badge2.backgroundColor = defaultColor(.lightBlue)
            self.badge2.text = badge2.rawValue
        }
    }
    
    
    private func setUpView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actualPriceLabel)
        addSubview(originalPriceLabel)
        addSubview(badge1)
        addSubview(badge2)
        
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: imageView.topAnchor, constant: 11),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            actualPriceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actualPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            originalPriceLabel.topAnchor.constraint(equalTo: actualPriceLabel.topAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 4),
            badge1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            badge1.topAnchor.constraint(equalTo: actualPriceLabel.bottomAnchor, constant: 8),
            badge1.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor),
            badge2.leadingAnchor.constraint(equalTo: badge1.trailingAnchor, constant: 4),
            badge2.topAnchor.constraint(equalTo: badge1.topAnchor)
        ])
    }
    
    
    
    class BadgeLabel: UILabel {
        
        @IBInspectable var topInset: CGFloat = 4.0
        @IBInspectable var bottomInset: CGFloat = 4.0
        @IBInspectable var leftInset: CGFloat = 5.0
        @IBInspectable var rightInset: CGFloat = 5.0
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        init() {
            super.init(frame: CGRect.zero)
            translatesAutoresizingMaskIntoConstraints = false
            textColor = .white
            font = defaultFont(.sansBold, size: 12)
        }
        
        override func drawText(in rect: CGRect) {
            self.layer.cornerRadius = 5
            self.clipsToBounds = true
            let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: rect.inset(by: insets))
        }
        
        override var intrinsicContentSize: CGSize {
            get {
                var contentSize = super.intrinsicContentSize
                contentSize.height += topInset + bottomInset
                contentSize.width += leftInset + rightInset
                return contentSize
            }
        }
    }
    
}

