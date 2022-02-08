//
//  MenuDataSource.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/06.
//

import Foundation
import UIKit

class FoodSource: NSObject, UICollectionViewDataSource {
    private let foodListViewModel: FoodListViewModel
    
    private let headerContent = ["모두가 좋아하는 든든한 메인요리",
                                 "정성이 담긴 뜨끈뜨끈 국물요리",
                                 "식탁을 풍성하게 하는 정갈한 밑반찬"]
    
    init(viewModel: FoodListViewModel) {
        self.foodListViewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return foodListViewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodListViewModel.numbersOfItems(groupIndex: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCell.reuseIdentifier, for: indexPath) as! FoodCell
        let storeItem = foodListViewModel.item(groupIndex: indexPath.section, itemIndex: indexPath.row)
        
        cell.set(content: storeItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuTitleSupplementaryView.reuseIdentifier, for: indexPath) as! MenuTitleSupplementaryView
        
        view.set(content: headerContent[indexPath.section])
        
        return view
    }
}
