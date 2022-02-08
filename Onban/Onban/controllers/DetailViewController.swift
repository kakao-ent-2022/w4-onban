//
//  DetailViewController.swift
//  Onban
//
//  Created by lauren.c on 2022/02/08.
//

import UIKit

class DetailViewController: UIViewController {
    var model: Food?
    
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
    
    private let pointLabel: SubDescriptionLabel = {
        let label = SubDescriptionLabel()
        label.textColor = defaultColor(.gray2)
        return label
    }()
    
    private let deliveryLabel: SubDescriptionLabel = {
        let label = SubDescriptionLabel()
        label.textColor = defaultColor(.gray2)
        return label
    }()
    
    private let deliveryFeeLabel: SubDescriptionLabel = {
        let label = SubDescriptionLabel()
        label.textColor = defaultColor(.gray2)
        return label
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not yet implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        view = UIScrollView()
        view.backgroundColor = .white
        setUpView()
    }
    
    private func setUpView() {
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(actualPriceLabel)
        view.addSubview(originalPriceLabel)
        view.addSubview(badgeStack)
        
        if let id = model?.id {
            imageView.image = loadImageFromDiskWith(fileName: id)
        }
        titleLabel.text = model?.title
        descriptionLabel.text = model?.description
        actualPriceLabel.text = model?.actualPrice
        if var originalPrice = model?.originalPrice {
            if originalPrice.last != "원" {
                originalPrice += "원"
            }
            self.originalPriceLabel.attributedText = NSAttributedString.init(string: originalPrice, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        }
        
        if let model = model, model.badge.contains(where: { $0 == .event }) {
            let eventLabel = BadgeLabel()
            eventLabel.text = "이벤트특가"
            eventLabel.backgroundColor = defaultColor(.green)
            badgeStack.addArrangedSubview(eventLabel)
        }
        if let model = model, model.badge.contains(where: { $0 == .launch }) {
            let launchLabel = BadgeLabel()
            launchLabel.text = "런칭특가"
            launchLabel.backgroundColor = defaultColor(.lightBlue)
            badgeStack.addArrangedSubview(launchLabel)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
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
        view.addSubview(divider1)
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
        
        pointLabel.text = String(Int((model?.actualPrice ?? "0").filter { $0.isNumber })! / 100)
        deliveryLabel.text = "서울 경기 새벽배송 / 전국택배 (제주 및 도서산간 불가) [월 · 화 · 수 · 목 · 금 · 토] 수령 가능한 상품입니다"
        
        let deliveryFeeString = "2,500원 (40,000원 이상 구매 시 무료)"
        let deliveryFee = NSMutableAttributedString(string: deliveryFeeString)
        deliveryFee.setAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], range: NSRange(6..<deliveryFeeString.count))
        deliveryFeeLabel.attributedText = deliveryFee
        
        
        
        view.addSubview(pointDescriptionLabel)
        view.addSubview(deliveryDescriptionLabel)
        view.addSubview(deliveryFeeDescriptionLabel)
        view.addSubview(pointLabel)
        view.addSubview(deliveryLabel)
        view.addSubview(deliveryFeeLabel)
        NSLayoutConstraint.activate([
            pointDescriptionLabel.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 24),
            pointDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            deliveryDescriptionLabel.topAnchor.constraint(equalTo: pointDescriptionLabel.bottomAnchor, constant: 16),
            deliveryDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            deliveryFeeDescriptionLabel.topAnchor.constraint(equalTo: deliveryDescriptionLabel.bottomAnchor, constant: 16),
            deliveryFeeDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            pointLabel.topAnchor.constraint(equalTo: pointDescriptionLabel.topAnchor),
            pointLabel.leadingAnchor.constraint(equalTo: pointDescriptionLabel.trailingAnchor, constant: 16),
            deliveryLabel.topAnchor.constraint(equalTo: deliveryDescriptionLabel.topAnchor),
            deliveryLabel.leadingAnchor.constraint(equalTo: pointLabel.leadingAnchor),
            deliveryFeeLabel.topAnchor.constraint(equalTo: deliveryFeeDescriptionLabel.topAnchor),
            deliveryFeeLabel.leadingAnchor.constraint(equalTo: pointLabel.leadingAnchor)
        ])
        
        let divider2: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray5
            return view
        }()
        view.addSubview(divider2)
        NSLayoutConstraint.activate([
            divider2.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            divider2.topAnchor.constraint(equalTo: deliveryFeeDescriptionLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private class SubDescriptionLabel: UILabel {
        required init?(coder: NSCoder) {
            fatalError("not yet implemented")
        }
        init() {
            super.init(frame: CGRect.zero)
            translatesAutoresizingMaskIntoConstraints = false
            font = defaultFont(.sansLight, size: 14)
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
}
