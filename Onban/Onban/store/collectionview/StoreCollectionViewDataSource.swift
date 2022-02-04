//
//  StoreCollectionViewDataSource.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation
import UIKit

class StoreCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreConstant.storeCollectionViewCellIdentifier , for: indexPath)
        
        return cell
    }
}
