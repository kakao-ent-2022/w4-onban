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
    let badgeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
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
        
        if let image = loadImageFromDiskWith(fileName: model.id) {
            self.imageView.image = image
        } else {
            self.imageView.image = UIImage(named: "loading-food-list")
        }
        
        badgeStack.arrangedSubviews[0].isHidden = !model.badge.contains { $0 == .event }
        badgeStack.arrangedSubviews[1].isHidden = !model.badge.contains { $0 == .launch }
    }
    
    func clear() {
        originalPriceLabel.text = ""
    }
    
    
    private func setUpView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actualPriceLabel)
        addSubview(originalPriceLabel)
        addSubview(badgeStack)
        
        let eventLabel = BadgeLabel()
        eventLabel.text = "이벤트특가"
        eventLabel.backgroundColor = defaultColor(.green)
        badgeStack.addArrangedSubview(eventLabel)
        
        let launchLabel = BadgeLabel()
        launchLabel.text = "런칭특가"
        launchLabel.backgroundColor = defaultColor(.lightBlue)
        badgeStack.addArrangedSubview(launchLabel)
        
        let rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(rightView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            rightView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            rightView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            rightView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: rightView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            actualPriceLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            actualPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            originalPriceLabel.topAnchor.constraint(equalTo: actualPriceLabel.topAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 4),
            badgeStack.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            badgeStack.topAnchor.constraint(equalTo: actualPriceLabel.bottomAnchor, constant: 8),
            badgeStack.bottomAnchor.constraint(equalTo: rightView.bottomAnchor),
        ])
        
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
    
    
    
}

