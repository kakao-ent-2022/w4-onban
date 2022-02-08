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
    private let imageCache = NSCache<NSString, UIImage>()
    private var imageKey: NSString?
    
    init(food: Food) {
        self.food = food
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let key = self.imageKey {
            let cachedImage = imageCache.object(forKey: key)
            completion(cachedImage)
        } else {
            guard let imageURL = URL(string: food.imageURL) else { return }
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let downloadTask = session.downloadTask(with: imageURL) { url, response, error in
                guard
                    let url = url, error == nil,
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else {
                    return
                }
                let cacheKey = url.lastPathComponent as NSString
                self.imageCache.setObject(image, forKey: cacheKey)
                completion(image)
            }
            downloadTask.resume()
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
    
    subscript(index: Int) -> FoodViewModel {
        return FoodViewModel(food: foods[index])
    }
}
