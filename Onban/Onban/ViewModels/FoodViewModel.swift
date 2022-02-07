//
//  FoodViewModel.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import UIKit

class FoodViewModel {
    let food: Food
    
    var title: String { food.title }
    var description: String { food.description}
    var nPrice: String? {
        food.nPrice == nil ? nil : food.nPrice! + "원"
    }
    var sPrice: String { food.sPrice }
    var imageData: Data?
    var image: UIImage?
    var isEvent: Bool {
        return food.badges?.contains("이벤트특가") ?? false
    }
    var isNew: Bool {
        return food.badges?.contains("론칭특가") ?? false
    }
    
    init(food: Food) {
        self.food = food
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = self.image {
            completion(image)
        } else {
            guard let imageURL = URL(string: food.imageURL) else { return }
            let task = URLSession.shared.dataTask(with: imageURL) { [self] data, response, error in
                guard let data = data, error == nil else { return }
                let image = UIImage(data: data)
                self.image  = image
                completion(image)
            }
            task.resume()
        }
    }
}

enum FoodsType {
    case main
    case side
    case soup
}

struct FoodsViewModel {
    let type: FoodsType
    let foods: [Food]
    var count: Int {
        return foods.count
    }
    
    subscript(index: Int) -> FoodViewModel {
        return FoodViewModel(food: foods[index])
    }
}
