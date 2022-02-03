//
//  ViewController.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class ViewController: UIViewController {
    private let defaultMargin: CGFloat = 16
    
    private var dataSource: UICollectionViewDataSource?
    private let foodListViewModel: FoodListViewModel = FoodListViewModelImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - defaultMargin*2, height: 130)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: defaultMargin, bottom: 50, right: defaultMargin)
        
        collectionViewLayout.headerReferenceSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: MainCollectionHeader.height)
        
        let collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        dataSource = MainDataSource(foodListViewModel)
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: "default")
        collectionView.register(MainCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "default-header")
        
        view.addSubview(collectionView)
        let safeArea = view.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

}
