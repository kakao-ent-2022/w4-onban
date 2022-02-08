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
        fatalError("not yet implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpView() {
        
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - defaultMargin*2, height: 130)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: defaultMargin, bottom: 24, right: defaultMargin)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: FoodListCollectionHeader.height)
        
        let collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: collectionViewLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(FoodListCollectionCell.self, forCellWithReuseIdentifier: "default")
        collectionView.register(FoodListCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "default-header")
        
        self.view = collectionView
        self.collectionView = collectionView
    }
    
    private func requestData() {
        struct DataResponse: Decodable {
            let statusCode: Int
            let body: [Food]
        }
        
        let request = NetworkRequest()
        let session = request.getSessionManager(delegate: nil)
        let urls = [
            "https://api.codesquad.kr/onban/main",
            "https://api.codesquad.kr/onban/soup",
            "https://api.codesquad.kr/onban/side"
        ]
        
        for (i, url) in urls.enumerated() {
            let task = session.getDataTask(with: URL(string: url)!,
                                           completionHandler: { data in
                if let data = data, let result = try? JSONDecoder().decode(DataResponse.self, from: data) {
                    self.foodListViewModel.insert(data: result.body, at: i)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadSections(IndexSet(integer: i))
                        self.downloadImage(from: self.foodListViewModel.get(section: i))
                    }
                }
            } )
            task.priority = 1.0 - (0.1 * Float(i))
            task.resume()
        }
    }
    
    private func downloadImage(from foods: [Food]) {
        let request = NetworkRequest()
        let session = request.getSessionManager(delegate: nil)
        for food in foods {
            let task = session.getDownloadTask(with: URL(string: food.imagePath)!) { (url) in
                if let url = url,
                   let image = UIImage(contentsOfFile: url.path) {
                    DispatchQueue.main.async {
                        self.saveImage(fileName: food.id, image: image)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func saveImage(fileName: String, image: UIImage) {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        
        let fileName = fileName
        let fileURL = cachesDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return
        }
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file", error)
        }
    }
}

extension FoodListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = foodListViewModel.get(section: indexPath.section, row: indexPath.row)
        let destination = DetailViewController()
        destination.model = item
        destination.title = item.title
        show(destination, sender: self)
    }
}

