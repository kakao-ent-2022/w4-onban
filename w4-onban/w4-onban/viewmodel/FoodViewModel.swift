//
//  FoodViewModel.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/10.
//

import Foundation

protocol FoodViewModel {
    var title: String { get }
    func addObserver(observer: Any, selector: Selector) 
}

extension NSNotification.Name {
    static let foodDetail = NSNotification.Name("foodDetail")
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
    
    func addObserver(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: .foodDetail, object: nil)
    }
}
