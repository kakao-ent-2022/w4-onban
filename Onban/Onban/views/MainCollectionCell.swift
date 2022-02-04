//
//  MainCollectionCell.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = defaultFont(.sansMedium, size: 14)
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
        label.font = defaultFont(.sansMedium, size: 14)
        return label
    }()
    
    let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = defaultColor(.lightGray)
        label.font = defaultFont(.sansLight, size: 14)
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
        if let url = URL(string: model.imagePath),
           let data = try? Data(contentsOf: url) {
            self.imageView.image = UIImage(data: data as Data)
        }
    }
    
    private func setUpView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actualPriceLabel)
        addSubview(originalPriceLabel)
        
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 11),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            actualPriceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actualPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            originalPriceLabel.topAnchor.constraint(equalTo: actualPriceLabel.topAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 4)
        ])
    }
}
