//
//  MainDataSource.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class MainDataSource: NSObject, UICollectionViewDataSource {
    let foodListVM: FoodListViewModel
    
    init(_ foodListVM: FoodListViewModel) {
        self.foodListVM = foodListVM
        super.init()
    }
    
    let headerTexts = ["모두가 좋아하는 든든한 메인요리", "정성이 담긴 뜨끈뜨끈 국물요리", "식탁을 풍성하게 하는 정갈한 밑반찬"]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return foodListVM.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodListVM.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! MainCollectionCell
        let model = foodListVM.get(section: indexPath.section, row: indexPath.row)
        cell.configure(from: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "default-header", for: indexPath) as! MainCollectionHeader
        header.title.text = headerTexts[indexPath.section]
        return header
    }
    
}
