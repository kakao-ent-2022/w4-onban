//
//  ViewController.swift
//  Onban
//
//  Created by river.o on 2022/02/03.
//

import UIKit

struct StoreConstant {
    static let storeCollectionViewHeaderIdentifier = "storeCollectionViewHeader"
    static let storeCollectionViewCellIdentifier = "storeCollectionViewCell"
}

class StoreViewController: UIViewController {
    
    private let storeCollectionViewDataSource = StoreCollectionViewDataSource()
    private let storeCollectionViewDelegate = StoreCollectionViewDelegate()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func initView() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func initCollectionView() {
        collectionView.register(StoreCollectionViewHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StoreConstant.storeCollectionViewHeaderIdentifier)
        collectionView.register(StoreCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: StoreConstant.storeCollectionViewCellIdentifier)
        collectionView.dataSource = storeCollectionViewDataSource
        collectionView.delegate = storeCollectionViewDelegate
        storeCollectionViewDataSource.addJsonData(jsonName: "main")
    }
}

