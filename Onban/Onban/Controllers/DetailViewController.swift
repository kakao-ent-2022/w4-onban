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
    var foodImage: UIImageView = UIImageView(image: UIImage(named: "foodThumbnail.png"))
    
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
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel, priceStackView, tagStackView])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setViews()
        
    }
    
    func setViews() {
        self.view.addSubview(foodImage)
        foodImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.topMargin)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(foodImage.snp.width)
        }
        
        self.view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom)
            make.centerX.equalTo(self.view.snp.centerX)
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
                    self.originalPrice.text = data.data.prices[0]
                    self.currentPrice.text = data.data.prices[1]
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
