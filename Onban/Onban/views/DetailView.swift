//
//  DetailView.swift
//  Onban
//
//  Created by lauren.c on 2022/02/09.
//

import UIKit

class DetailView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("not yet implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }

    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.image = UIImage(named: "loading-food-list")
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = defaultFont(.sansBold, size: 24)
        view.textColor = defaultColor(.font)
        view.numberOfLines = 0
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = defaultFont(.sansLight, size: 16)
        view.textColor = defaultColor(.subFont)
        view.numberOfLines = 0
        return view
    }()
    
    let actualPriceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = defaultFont(.sansBold, size: 24)
        view.textColor = defaultColor(.font)
        return view
    }()
    
    let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = defaultColor(.lightGray)
        label.font = defaultFont(.sansLight, size: 16)
        return label
    }()
    
    let badgeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let pointLabel: SubDescriptionLabel = {
        let label = SubDescriptionLabel()
        label.textColor = defaultColor(.gray2)
        return label
    }()
    
    let deliveryInfoLabel: SubDescriptionLabel = {
        let label = SubDescriptionLabel()
        label.textColor = defaultColor(.gray2)
        label.numberOfLines = 0
        return label
    }()
    
    let deliveryFeeLabel: SubDescriptionLabel = {
        let label = SubDescriptionLabel()
        label.textColor = defaultColor(.gray2)
        label.numberOfLines = 0
        
        return label
    }()
    
    class SubDescriptionLabel: UILabel {
        required init?(coder: NSCoder) {
            fatalError("not yet implemented")
        }
        init() {
            super.init(frame: CGRect.zero)
            translatesAutoresizingMaskIntoConstraints = false
            font = defaultFont(.sansLight, size: 14)
        }
    }
    
    func configure(from model: FoodDetail, with food: Food?) {
        
        titleLabel.text = model.productDescription
        guard model.prices.count >= 2 else {
            return
        }
        actualPriceLabel.text = model.prices[1]

        let originalPrice = model.prices[0].last == "원" ? model.prices[0] : model.prices[0] + "원"
        self.originalPriceLabel.attributedText = NSAttributedString.init(string: originalPrice, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        deliveryInfoLabel.text = model.deliveryInfo
        pointLabel.text = model.point
        
        descriptionLabel.text = food?.description
        
        if let boldStartIndex = model.deliveryFee.firstIndex(of: "(")?.utf16Offset(in: model.deliveryFee) {
            let deliveryFee = NSMutableAttributedString(string: model.deliveryFee)
            deliveryFee.setAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], range: NSRange(boldStartIndex..<model.deliveryFee.count))
            deliveryFeeLabel.attributedText = deliveryFee
        }
        
        if let food = food, food.badge.contains(where: { $0 == .event }) {
            let eventLabel = BadgeLabel()
            eventLabel.text = "이벤트특가"
            eventLabel.backgroundColor = defaultColor(.green)
            badgeStack.addArrangedSubview(eventLabel)
        }
        if let food = food, food.badge.contains(where: { $0 == .launch }) {
            let launchLabel = BadgeLabel()
            launchLabel.text = "런칭특가"
            launchLabel.backgroundColor = defaultColor(.lightBlue)
            badgeStack.addArrangedSubview(launchLabel)
        }
    }
    
    
    private func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let cachesDirectory = FileManager.SearchPathDirectory.cachesDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(cachesDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actualPriceLabel)
        addSubview(originalPriceLabel)
        addSubview(badgeStack)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actualPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            actualPriceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            originalPriceLabel.bottomAnchor.constraint(equalTo: actualPriceLabel.bottomAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 8),
            badgeStack.leadingAnchor.constraint(equalTo: actualPriceLabel.leadingAnchor),
            badgeStack.topAnchor.constraint(equalTo: actualPriceLabel.bottomAnchor, constant: 8),
        ])
        
        let divider1: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray5
            return view
        }()
        addSubview(divider1)
        NSLayoutConstraint.activate([
            divider1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            divider1.topAnchor.constraint(equalTo: badgeStack.bottomAnchor, constant: 24)
        ])
        
        let pointDescriptionLabel = SubDescriptionLabel()
        pointDescriptionLabel.text = "적립금"
        pointDescriptionLabel.textColor = defaultColor(.gray3)
        
        let deliveryDescriptionLabel = SubDescriptionLabel()
        deliveryDescriptionLabel.text = "배송정보"
        deliveryDescriptionLabel.textColor = defaultColor(.gray3)
        
        let deliveryFeeDescriptionLabel = SubDescriptionLabel()
        deliveryFeeDescriptionLabel.text = "배송비"
        deliveryFeeDescriptionLabel.textColor = defaultColor(.gray3)

        
        addSubview(pointDescriptionLabel)
        addSubview(deliveryDescriptionLabel)
        addSubview(deliveryFeeDescriptionLabel)
        addSubview(pointLabel)
        addSubview(deliveryInfoLabel)
        addSubview(deliveryFeeLabel)
        NSLayoutConstraint.activate([
            pointDescriptionLabel.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 24),
            pointDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            pointLabel.topAnchor.constraint(equalTo: pointDescriptionLabel.topAnchor),
            pointLabel.leadingAnchor.constraint(equalTo: pointDescriptionLabel.trailingAnchor, constant: 16),
            deliveryDescriptionLabel.topAnchor.constraint(equalTo: pointDescriptionLabel.bottomAnchor, constant: 16),
            deliveryDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            deliveryInfoLabel.topAnchor.constraint(equalTo: deliveryDescriptionLabel.topAnchor),
            deliveryInfoLabel.leadingAnchor.constraint(equalTo: pointLabel.leadingAnchor),
            deliveryInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            deliveryFeeDescriptionLabel.topAnchor.constraint(equalTo: deliveryInfoLabel.bottomAnchor, constant: 16),
            deliveryFeeDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            deliveryFeeLabel.topAnchor.constraint(equalTo: deliveryFeeDescriptionLabel.topAnchor),
            deliveryFeeLabel.leadingAnchor.constraint(equalTo: pointLabel.leadingAnchor),
            deliveryFeeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        let divider2: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray5
            return view
        }()
        addSubview(divider2)
        NSLayoutConstraint.activate([
            divider2.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            divider2.topAnchor.constraint(equalTo: deliveryFeeLabel.bottomAnchor, constant: 24),
            divider2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
