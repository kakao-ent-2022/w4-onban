//
//  StoreCollectionViewDataSource.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation
import UIKit

class StoreCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let headerTexts = [
        "메인반찬 / 한그릇 뚝딱 메인 요리",
        "국.찌게 / 김이 모락모락 국.찌게",
        "밑반찬 / 언제 먹어도 든든한 밑반찬",
    ]
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StoreConstant.storeCollectionViewHeaderIdentifier, for: indexPath) as? StoreCollectionViewHeader else {
                fatalError("no view")
            }
            
            let headerText = headerTexts[indexPath.row]
            headerView.bind(headerText: headerText)
            
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
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
