//
//  FoodViewModel.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import UIKit

class FoodViewModel {
    let food: Food
    
    var hashID: String { food.hashID }
    var title: String { food.title }
    var description: String { food.description}
    var nPrice: String? { food.nPrice }
    var sPrice: String { food.sPrice }
    var isEvent: Bool {
        return food.badges?.contains("이벤트특가") ?? false
    }
    var isNew: Bool {
        return food.badges?.contains("런칭특가") ?? false
    }
    private var imageKey: NSString?
    
    init(food: Food) {
        self.food = food
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageCacheManager.shared.loadImage(imageURL: food.imageURL) { image in
            completion(image)
        }
    }
}

enum FoodsType: Int {
    case main
    case side
    case soup
    
    func JSONURL() -> String {
        switch self {
        case .main:
            return "https://api.codesquad.kr/onban/main"
        case .soup:
            return "https://api.codesquad.kr/onban/soup"
        case .side:
            return "https://api.codesquad.kr/onban/side"
        }
    }
    
    func headerTitle() -> String {
        switch self {
        case .main:
            return "메인반찬 / 한그릇 뚝딱 메인 요리"
        case .soup:
            return "국.찌게 / 김이 모락모락 국.찌게"
        case .side:
            return "밑반찬 / 언제 먹어도 든든한 밑반찬"
        }
    }
}

struct FoodsViewModel {
    let type: FoodsType
    let foods: [Food]
    var count: Int {
        return foods.count
    }
    
    init(type: FoodsType, foods: [Food]) {
        self.type = type
        self.foods = foods
        self.foods.forEach { food in
            let url = food.imageURL
            ImageCacheManager.shared.loadImage(imageURL: url, completion: nil)
        }
    }
    
    subscript(index: Int) -> FoodViewModel {
        return FoodViewModel(food: foods[index])
    }
}
