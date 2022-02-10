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
    
    private let thumbImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "menuDefaultImage")
        return $0
    }(UIImageView())
    
    private let contentStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(onbanStyle: .bold, size: 24)
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(onbanStyle: .regular, size: 16)
        return $0
    }(UILabel())
    
    private let priceStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        return $0
    }(UIStackView())
    
    private let salePriceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(onbanStyle: .bold, size: 24)
        return $0
    }(UILabel())
    
    private let beforeSalePriceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(onbanStyle: .regular, size: 16)
        return $0
    }(UILabel())
    
    private lazy var badgeStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [eventBadgeLable, launchEventBadgeLable]))

    let eventBadgeLable: UILabel = {
        let view = BadgeLabel(badge: .event)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let launchEventBadgeLable: UILabel = {
        let view = BadgeLabel(badge: .launchEvent)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = foodViewModel.title
        navigationItem.backButtonTitle = "뒤로"
        
        priceStackView.addArrangedSubview(salePriceLabel)
        priceStackView.addArrangedSubview(beforeSalePriceLabel)
        priceStackView.sizeToFit()
        
        
        scrollView.addSubview(thumbImageView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(priceStackView)
        contentStackView.addArrangedSubview(badgeStackView)
        

        
        contentStackView.setCustomSpacing(8, after: nameLabel)
        contentStackView.setCustomSpacing(16, after: descriptionLabel)
        contentStackView.setCustomSpacing(8, after: priceStackView)
        
        priceStackView.setCustomSpacing(8, after: salePriceLabel)
        
        
        
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            thumbImageView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            thumbImageView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            thumbImageView.widthAnchor.constraint(equalTo: thumbImageView.heightAnchor),
            
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            contentStackView.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 24)
            
        ])
    }
    
    func set(food: Food) {
        let repository = RemoteRepositoryImple()
        foodViewModel = FoodViewModelImpl(food, repository: repository)
        foodViewModel.addObserver(observer: self, selector: #selector(didLoadFoodDetail))
        
        nameLabel.text = food.title
        descriptionLabel.text = food.description
        salePriceLabel.text = food.salePrice
        beforeSalePriceLabel.text = food.beforeSalePrice
    }
    
    @objc func didLoadFoodDetail(_ notification: Notification) {
        let foodDetail: FoodDetail = notification.userInfo?["foodDetailKey"] as! FoodDetail
        self.set(foodDetail: foodDetail)
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
        
       
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

