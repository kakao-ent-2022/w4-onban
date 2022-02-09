//
//  DetailViewController.swift
//  Onban
//
//  Created by terry.yes on 2022/02/07.
//

import UIKit

struct DetailFood: Decodable {
    let hash: String
    let data: DetailFoodData
}

struct DetailFoodData: Decodable {
    let topImage: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]
    
    private enum CodingKeys: String, CodingKey {
        
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
}

class DetailViewController: UIViewController {
    var hashID: String!
    
    let scrollView: UIScrollView = UIScrollView()
    var foodImage: UIImageView = UIImageView(image: UIImage(named: "foodThumbnail.png"))
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        return label
    }()
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .gray
        return label
    }()
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentPriceLabel, originalPriceLabel])
        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    let eventTagImage: UIImageView = UIImageView(image: UIImage(named: "eventTag.png"))
    let newTagImage: UIImageView = UIImageView(image: UIImage(named: "newTag.png"))
    
    private lazy var tagStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventTagImage, newTagImage])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    let lineView1: UIView = {
        let view = UIView(frame: CGRect())
        view.backgroundColor = .gray
        return view
    }()
    let pointTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.text = "적립금"
        return label
    }()
    let pointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .darkGray
        return label
    }()
    private lazy var pointStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pointTitleLabel, pointLabel])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    let deliveryInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.text = "배송정보"
        return label
    }()
    let deliveryInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    private lazy var deliveryInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deliveryInfoTitleLabel, deliveryInfoLabel])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let deliveryFeeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.text = "배송비"
        return label
    }()
    let deliveryFeeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .darkGray
        return label
    }()
    private lazy var deliveryFeeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deliveryFeeTitleLabel, deliveryFeeLabel])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    let lineView2: UIView = {
        let view = UIView(frame: CGRect())
        view.backgroundColor = .gray
        return view
    }()
    let stockTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.text = "수량"
        return label
    }()
    let stockTextField: UITextField = {
        let textField = UITextField()
        textField.text = "1"
        return textField
    }()
    
    let increaseStockButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.up")
        button.setImage(image, for: .normal)
        return button
    }()
    let decreaseStockButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        return button
    }()
    private lazy var stockButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [increaseStockButton, decreaseStockButton])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    private lazy var stockControlStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stockTextField, stockButtonStackView])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private lazy var stockStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stockTitleLabel, stockControlStackView])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 260
        return stackView
    }()
    
    let totalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 주문금액"
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "5,200원"
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    private lazy var totalPriceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalPriceTitleLabel, totalPriceLabel])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 150
        return stackView
    }()
    let orderButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "orderButton")
        button.setImage(image, for: .normal)
        return button
    }()
    let soldoutButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "soldoutButton")
        button.setImage(image, for: .normal)
        return button
    }()
    
    let bottomImageView1 = UIImageView()
    let bottomImageView2 = UIImageView()
    let bottomImageView3 = UIImageView()
    
    let contentsView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setViews()
    }
    
    
    func setViews() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentsView)
        contentsView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        
        contentsView.addSubview(foodImage)
        foodImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentsView.snp.topMargin)
            make.centerX.equalTo(self.contentsView.snp.centerX)
            make.width.equalTo(self.contentsView.snp.width)
            make.height.equalTo(foodImage.snp.width)
        }
        
        contentsView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }

        contentsView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        contentsView.addSubview(priceStackView)
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        contentsView.addSubview(tagStackView)
        tagStackView.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        contentsView.addSubview(lineView1)
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(tagStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(1)
        }

        contentsView.addSubview(pointStackView)
        pointStackView.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        pointLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentsView.snp.trailing).multipliedBy(0.3)
        }

        contentsView.addSubview(deliveryInfoStackView)
        deliveryInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(pointStackView.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
        deliveryInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentsView.snp.trailing).multipliedBy(0.3)
            make.trailing.equalToSuperview()
        }
        
        contentsView.addSubview(deliveryFeeStackView)
        deliveryFeeStackView.snp.makeConstraints { make in
            make.top.equalTo(deliveryInfoStackView.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }

        deliveryFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentsView.snp.trailing).multipliedBy(0.3)
            make.trailing.equalToSuperview()
        }
        
        contentsView.addSubview(lineView2)
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(deliveryFeeStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(1)
        }
        
        contentsView.addSubview(stockStackView)
        stockStackView.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        contentsView.addSubview(totalPriceStackView)
        totalPriceStackView.snp.makeConstraints { make in
            make.top.equalTo(stockStackView.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        contentsView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        contentsView.addSubview(bottomImageView1)
        bottomImageView1.snp.makeConstraints { make in
            make.top.equalTo(orderButton.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            let aspectRatio = bottomImageView1.image?.aspectRatio ?? 1
            make.height.equalTo(bottomImageView1.snp.width).multipliedBy(1 / aspectRatio)
            make.centerX.equalToSuperview()
        }
        
        contentsView.addSubview(bottomImageView2)
        bottomImageView2.snp.makeConstraints { make in
            make.top.equalTo(bottomImageView1.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            let aspectRatio = bottomImageView2.image?.aspectRatio ?? 1
            make.height.equalTo(bottomImageView2.snp.width).multipliedBy(1 / aspectRatio)
            make.centerX.equalToSuperview()
        }
        
        contentsView.addSubview(bottomImageView3)
        bottomImageView3.snp.makeConstraints { make in
            make.top.equalTo(bottomImageView2.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            let aspectRatio = bottomImageView3.image?.aspectRatio ?? 1
            make.height.equalTo(bottomImageView3.snp.width).multipliedBy(1 / aspectRatio)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    func configure(hashID: String) {
        self.hashID = hashID
        let baseURL = "https://api.codesquad.kr/onban/detail/"
        let urlString = baseURL + hashID
        JSONLoader.load(from: urlString, to: DetailFood.self) { result in
            switch result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.titleLabel.text = data.data.productDescription
                    self.detailLabel.text = data.data.productDescription
                    self.currentPriceLabel.text = data.data.prices[1]
                    let originalPrice = data.data.prices[0]
                    let attributeString = NSMutableAttributedString(string: originalPrice)
                    attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
                    self.originalPriceLabel.attributedText = attributeString
                    self.pointLabel.text = data.data.point
                    self.deliveryInfoLabel.text = data.data.deliveryInfo
                    self.deliveryFeeLabel.text = data.data.deliveryFee
                    ImageCacheManager.shared.loadImage(imageURL: data.data.thumbImages[0]) { image in
                        DispatchQueue.main.async {
                            self.foodImage.image = image
                        }
                    }
                    ImageCacheManager.shared.loadImage(imageURL: data.data.detailSection[0]) { image in
                        DispatchQueue.main.async {
                            self.bottomImageView1.image = image
                        }
                    }
                    ImageCacheManager.shared.loadImage(imageURL: data.data.detailSection[1]) { image in
                        DispatchQueue.main.async {
                            self.bottomImageView2.image = image
                        }
                    }
                    ImageCacheManager.shared.loadImage(imageURL: data.data.detailSection[2]) { image in
                        DispatchQueue.main.async {
                            self.bottomImageView3.image = image
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
