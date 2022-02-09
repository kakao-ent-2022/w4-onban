//
//  DetailViewController.swift
//  Onban
//
//  Created by lauren.c on 2022/02/08.
//

import UIKit

class DetailViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView: DetailView = {
        let view = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var foodItem: Food?
    
    required init?(coder: NSCoder) {
        fatalError("not yet implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = foodItem?.title
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = defaultColor(.background)
        
        setupScrollView()
        contentView.detailImageDownloadDelegate = self

        let _ = try? requestData()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func requestData() throws -> FoodDetail {
        struct DataResponse: Decodable {
            let hash: String
            let data: FoodDetail
        }
        
        let request = NetworkRequest()
        let session = request.getSessionManager(delegate: nil)
        let url = "https://api.codesquad.kr/onban/detail/" + (self.foodItem?.id ?? "")
        
        let task = session.getDataTask(with: URL(string: url)!,
                                       successHandler: { data in
            if let data = data, let result = try? JSONDecoder().decode(DataResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.contentView.configure(from: result.data, with: self.foodItem)
                }
            }
        } )
        task.resume()
        throw CommonError.NETWORK_ERROR
    }
}

extension DetailViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let image = UIImage(contentsOfFile: location.path) {
            self.contentView.loadDetailSection(with: image)
        }
    }
}
