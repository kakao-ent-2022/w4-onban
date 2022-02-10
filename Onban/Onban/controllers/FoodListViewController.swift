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
        
        setupView()
        requestData()
    }
    required init?(coder: NSCoder) {
        fatalError("not yet implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupView() {
        let collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        
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
                                           successHandler: { data in
                if let data = data, let result = try? JSONDecoder().decode(DataResponse.self, from: data) {
                    self.foodListViewModel.insert(data: result.body, at: i)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadSections(IndexSet(integer: i))
                        self.downloadImage(section: i)
                    }
                }
            } )
            task.priority = 1.0 - (0.1 * Float(i))
            task.resume()
        }
    }
    
    private func downloadImage(section: Int) {
        let foods = self.foodListViewModel.get(section: section)
        let request = NetworkRequest()
        let session = request.getSessionManager(delegate: nil)
        for food in foods {
            let task = session.getDownloadTask(with: URL(string: food.imagePath)!) { (url) in
                if let url = url,
                   let image = UIImage(contentsOfFile: url.path),
                   !self.ifFileExist(fileName: food.id) {
                    DispatchQueue.global().async {
                        self.saveImage(fileName: food.id, image: image) {
                            self.collectionView?.reloadItems(at: [IndexPath(row: 1, section: 1)])
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func saveImage(fileName: String, image: UIImage, successHandler: (() -> Void)?) {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        
        let fileName = fileName
        let fileURL = cachesDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        do {
            try data.write(to: fileURL)
            DispatchQueue.main.async {
                successHandler?()
            }
        } catch let error {
            print("error saving file", error)
        }
    }
    
    private func ifFileExist(fileName: String) -> Bool {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return false }
        
        let fileName = fileName
        let fileURL = cachesDirectory.appendingPathComponent(fileName)
        
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
}

extension FoodListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = foodListViewModel.get(section: indexPath.section, row: indexPath.row)
        let destination = DetailViewController()
        destination.foodItem = item
        
        show(destination, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: defaultMargin, bottom: 24, right: defaultMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - defaultMargin*2, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: FoodListCollectionHeader.height)
    }
}

