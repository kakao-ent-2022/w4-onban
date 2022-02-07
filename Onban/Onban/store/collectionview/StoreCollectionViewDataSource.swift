//
//  StoreCollectionViewDataSource.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation
import UIKit

class StoreCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var stores: [StoreItem] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreConstant.storeCollectionViewCellIdentifier, for: indexPath) as? StoreCollectionViewCell else {
            fatalError("no cell")
        }
        
        let store = stores[indexPath.row]
        cell.bind(store: store)
        
        return cell
    }
    
    func addJsonData(jsonName: String) {
        if let url = Bundle.main.url(forResource: jsonName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let addStores = try JSONDecoder().decode([StoreItem].self, from: data)
                stores.append(contentsOf: addStores)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
