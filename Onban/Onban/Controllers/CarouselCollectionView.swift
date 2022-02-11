//
//  CarouselCollectionView.swift.swift
//  Onban
//
//  Created by terry.yes on 2022/02/10.
//

import Foundation
import UIKit

class CarouselCell: UICollectionViewCell {
    var imageView: UIImageView = UIImageView(image: UIImage(named: "foodThumbnail.png"))
    
    func configure(image: UIImage?) {
        imageView.image = image
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class CarouselCollectionView: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var detailThumnailVM: DetailThumnailViewModel?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailThumnailVM?.numberOfItemsInsection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as? CarouselCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(image: detailThumnailVM?.thumnailAtIndex(indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 360)
    }

}
