//
//  CounterView.swift
//  w4-onban
//
//  Created by nylah.j on 2022/02/11.
//

import Foundation
import UIKit

class CounterView: UIView {
    let countLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "0"
        $0.font = OnbanFontStyle.regular.font(size: 14)
        return $0
    }(UILabel())
    
    private lazy var buttonStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .fill
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [upButton, downButton]))
    
    let upButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let upImage = UIImage(named: "upButton")
        $0.setImage(upImage, for: .normal)
        return $0
    }(UIButton())
    
    let downButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let downImage = UIImage(named: "downButton")
        $0.setImage(downImage, for: .normal)
        return $0
    }(UIButton())
    
   
    
    init() {
        super.init(frame: CGRect.zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        self.addSubview(countLabel)
        self.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: countLabel.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: countLabel.bottomAnchor)
            
        ])
    }
}
