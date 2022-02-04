//
//  StoreCollectionViewCell.swift
//  Onban
//
//  Created by river.o on 2022/02/04.
//

import Foundation
import UIKit

class StoreCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    private func addViews() {
        let headerLabel: UILabel = {
            let label = UILabel()
            label.text = "Simple Cell"
            label.font = UIFont.systemFont(ofSize: 20)
            label.sizeToFit()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        addSubview(headerLabel)
        
        headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
