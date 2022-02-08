//
//  ViewController.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/03.
//

import UIKit
import Toaster

class MainViewController: UIViewController {
    static let horizontalPadding = CGFloat(16)
    
    private let foodListViewModel: FoodListViewModel
    private let foodSource: FoodSource
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        foodListViewModel = FoodListViewModelImpl()
        foodSource = FoodSource(viewModel: foodListViewModel)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        foodListViewModel = FoodListViewModelImpl()
        foodSource = FoodSource(viewModel: foodListViewModel)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        
        collectionView.register(MenuTitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuTitleSupplementaryView.reuseIdentifier)
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.reuseIdentifier)
        
        collectionView.dataSource = foodSource
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MainViewController.horizontalPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MainViewController.horizontalPadding),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        else {
            return CGSize()
        }
        flowLayout.minimumInteritemSpacing = 8
        
        let cellWidth = collectionView.bounds.width
            - MainViewController.horizontalPadding * 2
        
        let cellHeight = CGFloat(130)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard collectionViewLayout is UICollectionViewFlowLayout
        else {
            return CGSize()
        }
        
        let frameWidth = collectionView.bounds.width - MainViewController.horizontalPadding
        let cellHeight = CGFloat(32) + 24
        return CGSize(width: frameWidth, height: cellHeight)
    }
}


