//
//  FoodViewModel.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import Foundation

protocol FoodViewModel {
    var title: String { get }
    func addFoodDetailObserver(observer: Any, selector: Selector)
    func loadDetailSectionImages(imageUrls: [String])
    func addFoodDetailImagesObserver(observer: Any, selector: Selector) 
}

extension NSNotification.Name {
    static let foodDetail = NSNotification.Name("foodDetail")
    static let foodDetailImages = NSNotification.Name("foodDetailImages")
}

struct FoodViewModelImpl: FoodViewModel {
    static var foodDetailKey: String = "foodDetailKeyb"
    
    private let repository: Repository
    private let food: Food
    let notificationCenter =  NotificationCenter.default
    
    
    var title: String {
        return food.title
    }
    
    init(_ food: Food, repository: Repository) {
        self.food = food
        self.repository = repository
        self.loadDetail()
    }
    
    private func loadDetail() {
        repository.foodDetail(hash: food.detailHash) { result in
            
            switch(result) {
                
            case .success(let foodDetail):
                DispatchQueue.main.async {
                    self.notificationCenter.post(name: .foodDetail, object: nil, userInfo: ["foodDetailKey":foodDetail])
                }
            case .failure(_):
                print("load foodDetail fail")
            }
        }
    }
    
    func addFoodDetailObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: .foodDetail, object: nil)
    }
    
    func loadDetailSectionImages(imageUrls: [String]) {
        repository.foodDetailImages(imageUrls: imageUrls) { result in
            switch result {
                
            case .success(let data):
                self.notificationCenter.post(name: .foodDetailImages, object: nil, userInfo: ["foodDetailImages": data])
            case .failure(_):
                print("load foodDetail Section Image Fail")
            }
        }
    }
    
    func addFoodDetailImagesObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: .foodDetailImages, object: nil)
    }
}
