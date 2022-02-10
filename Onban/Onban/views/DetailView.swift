//
//  DetailView.swift
//  Onban
//
//  Created by lauren.c on 2022/02/09.
//

import UIKit

class DetailView: UIView {
    var detailImageDownloadDelegate: URLSessionDelegate?
    var timer: Timer?
    required init?(coder: NSCoder) {
        fatalError("not yet implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(changeThumbnail), userInfo: nil, repeats: true)
    }

    let thumbnailScrollView: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thumbnailStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    let detailSection: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = false
        return stackView
    }()
    
    let stepper: CountStepper = {
        let view = CountStepper()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let purchaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = defaultFont(.sansBold, size: 32)
        label.textColor = defaultColor(.font)
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
    
    @objc func changeThumbnail() {
        let currentOffset = thumbnailScrollView.contentOffset
        var offsetToMove = CGPoint(x: currentOffset.x + frame.width, y: currentOffset.y)
        if offsetToMove.x >= thumbnailStack.frame.width {
            offsetToMove.x = 0
        }
        thumbnailScrollView.setContentOffset(offsetToMove, animated: true)
    }
    
    func configure(from model: FoodDetail, with food: Food?) {
        
        for item in model.thumbnails {
            
            let session = NetworkRequest().getSessionManager(delegate: nil)
            let topImageTask = session.getDownloadTask(with: URL(string: item)!, completionHandler: { downloadUrl in
                if let downloadUrl = downloadUrl, let data = try? Data(contentsOf: downloadUrl) {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        let imageView = UIImageView(image: image)
                        self.thumbnailStack.addArrangedSubview(imageView)
                        imageView.translatesAutoresizingMaskIntoConstraints = false
                        imageView.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
                        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
                    }
                }
            })
            topImageTask.resume()
        }
        
        titleLabel.text = food?.title
        if model.prices.count < 2 {
            actualPriceLabel.text = model.prices[0]
        } else {
            actualPriceLabel.text = model.prices[1]
            
            let originalPrice = model.prices[0].last == "원" ? model.prices[0] : model.prices[0] + "원"
            self.originalPriceLabel.attributedText = NSAttributedString.init(string: originalPrice, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        }
        purchaseLabel.text = actualPriceLabel.text
        
        deliveryInfoLabel.text = model.deliveryInfo
        pointLabel.text = model.point
        
        descriptionLabel.text = model.productDescription
        
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
        
        
        let detailSession = NetworkRequest().getSessionManager(delegate: detailImageDownloadDelegate)
        for (i, url) in model.detailSection.enumerated() {
            let task = detailSession.session.downloadTask(with: URL(string: url)!)
            // [TODO] priority는 순서를 완전히 보장하지 않음.
            task.priority = 1.0 - (0.1 * Float(i))
            task.resume()
        }
    }
    
    func loadDetailSection(with image: UIImage) {
        DispatchQueue.main.async {
            let imageView = UIImageView(image: image)
            self.detailSection.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: self.detailSection.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: image.size.height / image.size.width).isActive = true
            imageView.contentMode = .scaleAspectFit
        }
    }

    
    private func setupView() {
        addSubview(thumbnailScrollView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actualPriceLabel)
        addSubview(originalPriceLabel)
        addSubview(badgeStack)
        
        thumbnailScrollView.addSubview(thumbnailStack)
        thumbnailScrollView.delegate = self
        NSLayoutConstraint.activate([
            thumbnailScrollView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailScrollView.widthAnchor.constraint(equalTo: widthAnchor),
            thumbnailScrollView.heightAnchor.constraint(equalTo: thumbnailScrollView.widthAnchor),
            thumbnailStack.topAnchor.constraint(equalTo: thumbnailScrollView.topAnchor),
            thumbnailStack.leadingAnchor.constraint(equalTo: thumbnailScrollView.leadingAnchor),
            thumbnailStack.trailingAnchor.constraint(equalTo: thumbnailScrollView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: thumbnailScrollView.bottomAnchor, constant: 24),
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
            deliveryInfoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            deliveryFeeDescriptionLabel.topAnchor.constraint(equalTo: deliveryInfoLabel.bottomAnchor, constant: 16),
            deliveryFeeDescriptionLabel.leadingAnchor.constraint(equalTo: divider1.leadingAnchor),
            deliveryFeeLabel.topAnchor.constraint(equalTo: deliveryFeeDescriptionLabel.topAnchor),
            deliveryFeeLabel.leadingAnchor.constraint(equalTo: pointLabel.leadingAnchor),
            deliveryFeeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
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
        ])
        
        let countDescriptionLabel = SubDescriptionLabel()
        countDescriptionLabel.text = "수량"
        countDescriptionLabel.textColor = defaultColor(.gray3)
        
        addSubview(countDescriptionLabel)
        addSubview(stepper)
        NSLayoutConstraint.activate([
            
            countDescriptionLabel.centerYAnchor.constraint(equalTo: stepper.centerYAnchor),
            countDescriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            stepper.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 16),
            stepper.widthAnchor.constraint(equalToConstant: 80),
            stepper.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            stepper.heightAnchor.constraint(equalTo: stepper.label.heightAnchor, constant: 10)
        ])
        
        let divider3: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray5
            return view
        }()
        addSubview(divider3)
        NSLayoutConstraint.activate([
            divider3.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            divider3.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            divider3.heightAnchor.constraint(equalToConstant: 1),
            divider3.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 16),
        ])
        
        let purchaseDescriptionLabel = UILabel()
        purchaseDescriptionLabel.text = "총 주문 금액"
        purchaseDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseDescriptionLabel.font = defaultFont(.sansBold, size: 18)
        purchaseDescriptionLabel.textColor = defaultColor(.subFont)
        
        let purchaseButton = UIButton()
        purchaseButton.backgroundColor = defaultColor(.green)
        purchaseButton.setTitle("주문하기", for: .normal)
        purchaseButton.titleLabel?.font = defaultFont(.sansBold, size: 18)
        purchaseButton.titleLabel?.textColor = .white
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.layer.cornerRadius = 5
        purchaseButton.layer.shadowColor = defaultColor(.lightGray)?.cgColor
        
        addSubview(purchaseDescriptionLabel)
        addSubview(purchaseLabel)
        addSubview(purchaseButton)
        
        NSLayoutConstraint.activate([
            purchaseDescriptionLabel.topAnchor.constraint(equalTo: divider3.bottomAnchor, constant: 34),
            purchaseDescriptionLabel.trailingAnchor.constraint(equalTo: purchaseLabel.leadingAnchor, constant: -24),
            purchaseLabel.centerYAnchor.constraint(equalTo: purchaseDescriptionLabel.centerYAnchor),
            purchaseLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            purchaseButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            purchaseButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            purchaseButton.topAnchor.constraint(equalTo: purchaseDescriptionLabel.bottomAnchor, constant: 34),
            purchaseButton.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        addSubview(detailSection)
        NSLayoutConstraint.activate([
            detailSection.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailSection.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailSection.topAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: 40),
            detailSection.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailSection.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension DetailView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}
