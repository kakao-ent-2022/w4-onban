//
//  MainCollectionCell.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func configure(from model: Food) {
        self.title.text = model.title
    }
    
    private func setUpView() {
        
        addSubview(view)
        addSubview(title)
        
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
