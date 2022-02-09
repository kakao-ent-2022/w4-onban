//
//  StoreCollectionViewHeaderCell.swift
//  Onban
//
//  Created by river.o on 2022/02/09.
//

import Foundation
import UIKit

class StoreCollectionViewHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .basicText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addViews() {
        addSubview(headerLabel)
        
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func bind(headerText: String) {
        headerLabel.text = headerText
    }
}
