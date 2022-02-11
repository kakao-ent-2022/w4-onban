//
//  StoreCollectionViewDataSource.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation
import UIKit

class StoreCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    enum StoreSection: Int, CaseIterable {
        case main = 0
        case soup = 1
        case side = 2
        
        static func withName(_ name: String) -> StoreSection? {
            return self.allCases.first{ "\($0)" == name }
        }
        
        var headerText: String {
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
    
    lazy var stores : [[StoreItem]] = {
        Array(repeating: [], count: StoreSection.allCases.count)
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StoreSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreConstant.storeCollectionViewCellIdentifier, for: indexPath) as? StoreCollectionViewCell else {
            fatalError("no cell")
        }
        
        let store = stores[indexPath.section][indexPath.row]
        cell.bind(store: store)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StoreConstant.storeCollectionViewHeaderIdentifier, for: indexPath) as? StoreCollectionViewHeader else {
                fatalError("no view")
            }
            
            guard let section = StoreSection.init(rawValue: indexPath.section) else {
                fatalError("no section")
            }
            headerView.bind(headerText: section.headerText)
            
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func initJson() {
        StoreSection.allCases.forEach {
            addJsonFileData(jsonName: "\($0)", index: $0.rawValue)
        }
    }
    
    func addJsonFileData(jsonName: String, index: Int) {
        if let url = Bundle.main.url(forResource: jsonName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let addStores = try JSONDecoder().decode([StoreItem].self, from: data)
                addStoreData(index: index, data: addStores)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addStoreData(index: Int, data: [StoreItem]) {
        stores[index] = data
    }
}
