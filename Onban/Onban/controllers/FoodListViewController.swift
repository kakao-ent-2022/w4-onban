//
//  ViewController.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit
import Toaster

class FoodListViewController: UIViewController {
    private let defaultMargin: CGFloat = 16
    
    private let foodListViewModel: FoodListViewModel
    private let dataSource: FoodListDataSource
    private var collectionView: UICollectionView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        foodListViewModel = FoodListViewModelImpl()
        dataSource = FoodListDataSource(foodListViewModel)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        foodListViewModel = FoodListViewModelImpl()
        dataSource = FoodListDataSource(foodListViewModel)
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        requestData()
    }
    
    private func setUpView() {
        
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - defaultMargin*2, height: 130)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: defaultMargin, bottom: 24, right: defaultMargin)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: FoodListCollectionHeader.height)
        
        let collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(FoodListCollectionCell.self, forCellWithReuseIdentifier: "default")
        collectionView.register(FoodListCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "default-header")

        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        self.collectionView = collectionView
    }
    
    private func requestData() {
        let request = NetworkRequest()
        let session = request.getSession(delegate: nil)
        let urls = [
            URL(string: "https://api.codesquad.kr/onban/main/")!,
            URL(string: "https://api.codesquad.kr/onban/soup")!,
            URL(string: "https://api.codesquad.kr/onban/side")!
        ]
        
        for (i, url) in urls.enumerated() {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          print("error")
                          return
                      }
                let decoder = JSONDecoder()
                
                if let data = data, let result = try? decoder.decode(DataResponse.self, from: data) {
                    self.foodListViewModel.insertDataList(data: result.body, at: i)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadSections(IndexSet(integer: i))
                    }
                } else {
                    print("some error")
                }
            }
            task.resume()
        }
        
        
    }
    
    private struct DataResponse: Decodable {
        let statusCode: Int
        let body: [Food]
    }
}

extension FoodListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = foodListViewModel.get(section: indexPath.section, row: indexPath.row)
        Toast(text: "\(dataSource.headerTexts[indexPath.section])\n가격은 \(item.actualPrice)").show()
    }
}

