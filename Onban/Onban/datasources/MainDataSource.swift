//
//  MainDataSource.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class MainDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! MainCollectionCell
        cell.configure(title: "not yet")
        return cell
    }
    
}
