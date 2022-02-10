//
//  DetailThumnailViewModel.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/10.
//

import UIKit

class DetailThumnailViewModel {
    var images = [UIImage]()
    init(urlStrings: [String]) {
        urlStrings.forEach { urlString in
            ImageCacheManager.shared.loadImage(imageURL: urlString) { [self] image in
                guard let image = image else { return }
                self.images.append(image)
            }
        }
    }
    
    func numberOfItemsInsection(_ section: Int) -> Int {
        return 2
    }
    
    func thumnailAtIndex(_ indexPath: IndexPath) -> UIImage {
        let index = indexPath.item
        return images.indices.contains(index) ? images[index] : UIImage()
    }
}
