//
//  DetailViewController.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import UIKit

class DetailViewController: UIViewController {
    private var foodViewModel: FoodViewModel!
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let thumbImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "menuDefaultImage")
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = OnbanFontStyle.bold.font(size: 24)
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = OnbanFontStyle.regular.font(size: 16)
        return $0
    }(UILabel())
    
    private lazy var priceStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .bottom
        return $0
    }(UIStackView(arrangedSubviews: [salePriceLabel, beforeSalePriceLabel]))
    
    private let salePriceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = OnbanFontStyle.bold.font(size: 24)
        return $0
    }(UILabel())
    
    private let beforeSalePriceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = OnbanFontStyle.regular.font(size: 16)
        return $0
    }(UILabel())
    
    private lazy var badgeStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [eventBadgeLable, launchEventBadgeLable]))

    private let eventBadgeLable: UILabel = {
        let view = BadgeLabel(badge: .event)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let launchEventBadgeLable: UILabel = {
        let view = BadgeLabel(badge: .launchEvent)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dividerView1: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = OnBanColor.divider.color
        return $0
    }(UIView(frame: CGRect()))
    
    private let dividerView2: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = OnBanColor.divider.color
        return $0
    }(UIView(frame: CGRect()))
    
    private let dividerView3: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = OnBanColor.divider.color
        return $0
    }(UIView(frame: CGRect()))
    
    private let pointTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.text = "적립금"
        return $0
    }(UILabel())
    
    private let deliveryInfoTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.text = "배송정보"
        return $0
    }(UILabel())
    
    private let deliveryFeeTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.text = "배송비"
        return $0
    }(UILabel())
    
    
    private let pointLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let deliveryInfoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let deliveryFeeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let countTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.regular.font(size: 14)
        $0.textAlignment = .left
        $0.text = "수량"
        return $0
    }(UILabel())
    
    private let counterView: CounterView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CounterView())
    
    private let totalPriceTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = OnBanColor.metaData.color
        $0.font = OnbanFontStyle.bold.font(size: 18)
        $0.text = "총 주문금액"
        return $0
    }(UILabel())
    
    private let totalPriceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = OnbanFontStyle.bold.font(size: 32)
        return $0
    }(UILabel())
    
    private lazy var orderButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("주문하기", for: .normal)
        $0.layer.cornerRadius = 5
        $0.backgroundColor = OnBanColor.orderButton.color
        return $0
    }(UIButton())
    
    private let detailImageStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.axis = .vertical
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = foodViewModel.title
        navigationItem.backButtonTitle = "뒤로"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceStackView)
        contentView.addSubview(badgeStackView)
        contentView.addSubview(dividerView1)
        contentView.addSubview(dividerView2)
        contentView.addSubview(dividerView3)
        contentView.addSubview(pointTitleLabel)
        contentView.addSubview(deliveryInfoTitleLabel)
        contentView.addSubview(deliveryFeeTitleLabel)
        contentView.addSubview(pointLabel)
        contentView.addSubview(deliveryFeeLabel)
        contentView.addSubview(deliveryInfoLabel)
        contentView.addSubview(countTitleLabel)
        contentView.addSubview(counterView)
        contentView.addSubview(totalPriceTitleLabel)
        contentView.addSubview(totalPriceLabel)
        contentView.addSubview(orderButton)
        contentView.addSubview(detailImageStack)
    
        priceStackView.setCustomSpacing(8, after: salePriceLabel)

        deliveryInfoTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        deliveryInfoLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        pointLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        deliveryFeeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentViewHeight,
        
            thumbImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            thumbImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            thumbImageView.widthAnchor.constraint(equalTo: thumbImageView.heightAnchor),
            thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            priceStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            priceStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            badgeStackView.topAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: 8),
            badgeStackView.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            dividerView1.topAnchor.constraint(equalTo: badgeStackView.bottomAnchor, constant: 24),
            dividerView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerView1.heightAnchor.constraint(equalToConstant: 1),
            
            pointTitleLabel.topAnchor.constraint(equalTo: dividerView1.bottomAnchor, constant: 24),
            pointTitleLabel.leadingAnchor.constraint(equalTo: dividerView1.leadingAnchor),
            
            deliveryInfoTitleLabel.topAnchor.constraint(equalTo: pointTitleLabel.bottomAnchor, constant: 16),
            deliveryInfoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            deliveryInfoLabel.leadingAnchor.constraint(equalTo: deliveryInfoTitleLabel.trailingAnchor, constant: 16),
            deliveryInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deliveryInfoLabel.topAnchor.constraint(equalTo: deliveryInfoTitleLabel.topAnchor),
            
            deliveryFeeTitleLabel.topAnchor.constraint(equalTo: deliveryInfoTitleLabel.bottomAnchor, constant: 16),
            deliveryFeeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            deliveryFeeLabel.topAnchor.constraint(equalTo: deliveryFeeTitleLabel.topAnchor),
            deliveryFeeLabel.leadingAnchor.constraint(equalTo: deliveryInfoTitleLabel.trailingAnchor, constant: 16),
            deliveryFeeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            pointLabel.leadingAnchor.constraint(equalTo: deliveryInfoTitleLabel.trailingAnchor, constant: 16),
            pointLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pointLabel.topAnchor.constraint(equalTo: pointTitleLabel.topAnchor),
            
            
            dividerView2.topAnchor.constraint(equalTo: deliveryFeeTitleLabel.bottomAnchor, constant: 24),
            dividerView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerView2.heightAnchor.constraint(equalToConstant: 1),
            
            countTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countTitleLabel.topAnchor.constraint(equalTo: dividerView2.bottomAnchor, constant: 35),
            
            counterView.centerYAnchor.constraint(equalTo: countTitleLabel.centerYAnchor),
            counterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dividerView3.topAnchor.constraint(equalTo: countTitleLabel.bottomAnchor, constant: 34),
            dividerView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerView3.heightAnchor.constraint(equalToConstant: 1),

            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            totalPriceLabel.topAnchor.constraint(equalTo: dividerView3.topAnchor, constant: 16),
            
            totalPriceTitleLabel.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
            totalPriceTitleLabel.trailingAnchor.constraint(equalTo: totalPriceLabel.leadingAnchor, constant: -24),
            
            orderButton.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 24),
            orderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            orderButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            orderButton.heightAnchor.constraint(equalToConstant: 58),
            
            detailImageStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailImageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailImageStack.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 40),
            detailImageStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    init(food: Food) {
        let repository = RemoteRepositoryImpl()
        foodViewModel = FoodViewModelImpl(food, repository: repository)
        
        nameLabel.text = food.title
        descriptionLabel.text = food.description
        salePriceLabel.text = food.salePrice
        beforeSalePriceLabel.text = food.beforeSalePrice
        totalPriceLabel.text = food.salePrice
        
        super.init(nibName: nil, bundle: nil)
        foodViewModel.addFoodDetailObserver(observer: self, selector: #selector(didLoadFoodDetail))
        
        foodViewModel.addFoodDetailImagesObserver(observer: self, selector: #selector(didLoadFoodDetailImages))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func didLoadFoodDetail(_ notification: Notification) {
        let foodDetail: FoodDetail = notification.userInfo?["foodDetailKey"] as! FoodDetail
        self.set(foodDetail: foodDetail)
    }
    
    @objc func didLoadFoodDetailImages(_ notification: Notification) {
        let foodDetailImages: [Data] =
        notification.userInfo?["foodDetailImages"] as! [Data]
        
        foodDetailImages.enumerated()
            .forEach { (index, data) in
                let imageView = detailImageStack.arrangedSubviews[safe: index] as! UIImageView
                imageView.image = UIImage(data: data)
            }
    }
    
    private func set(foodDetail: FoodDetail) {
        let thumbImagePath = foodDetail.thumbImages[safe: 0] ?? ""
        ImageLoader.instance.load(from: thumbImagePath) { result in
            switch result {
                
            case .success(let data):
                self.thumbImageView.image = UIImage(data: data)
            case .failure(_):
                break
            }
        }
        
        pointLabel.text = foodDetail.point
        deliveryInfoLabel.text = foodDetail.deliveryInfo
        deliveryFeeLabel.text = foodDetail.deliveryFee
        
        foodDetail.detailSectionImages.indices
            .forEach { _ in
                let imageView = UIImageView()
                imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor).isActive = true
                imageView.translatesAutoresizingMaskIntoConstraints = false
                detailImageStack.addArrangedSubview(imageView)
            }
        
        foodViewModel.loadDetailSectionImages(imageUrls: foodDetail.detailSectionImages)
    }
}
