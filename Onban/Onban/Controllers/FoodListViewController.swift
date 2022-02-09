//
//  MainViewController.swift
//  Onban
//
//  Created by terry.yes on 2022/02/03.
//


import UIKit
import SnapKit

class FoodListViewController: UIViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var foodListVM: FoodListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        addFoodData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setLayout() {
        view.backgroundColor = .white
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: "sideDishCell")
        collectionView.register(FoodHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "itemHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    private func addFoodData() {
        self.foodListVM = FoodListViewModel(foodsList: [])
        foodListVM?.addFoodViewModel(type: .main) {
            self.foodListVM?.addFoodViewModel(type: .soup, completion: {
                self.foodListVM?.addFoodViewModel(type: .side, completion: {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                })
            })
        }
    }
}

extension FoodListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let numberOfSection = foodListVM?.numberOfSection else { return .zero}
        return numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItem = foodListVM?.numberOfItemsInsection(section) else { return 0}
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sideDishCell", for: indexPath) as? FoodCell,
            let foodVM = foodListVM?.foodAtIndex(indexPath)
        else {
            return UICollectionViewCell()
        }
        cell.configure(foodVM: foodVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let foodVM = foodListVM?.foodAtIndex(indexPath) else { return }
        let hashID = foodVM.hashID
        let detailVC = DetailViewController()
        detailVC.configure(hashID: hashID)
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
   
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "itemHeaderView", for: indexPath) as? FoodHeaderView else {
            return UICollectionReusableView()
        }
        header.configure(title: foodListVM?.titleOfSection(indexPath.section))
        return header
                
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 160)
    }
}
