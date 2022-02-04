//
//  FoodViewModel.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/04.
//

import UIKit

struct FoodViewModel {
    let food: Food
    var title: String { food.title }
    var description: String { food.description}
    var nPrice: String? {
        food.nPrice == nil ? nil : food.nPrice! + "원"
    }
    var sPrice: String { food.sPrice }
    var imageData: Data?
    
    func loadImage(completion: @escaping (Data?) -> Void) {
        if let imageData = self.imageData {
            completion(imageData)
        } else {
            guard let imageURL = URL(string: food.imageURL) else { return }
            let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard error == nil else { return }
                completion(data)
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
