//
//  UIImage+AspectRatio.swift
//  Onban
//
//  Created by terry.yes on 2022/02/09.
//

import UIKit


extension UIImage {
    var aspectRatio: CGFloat? {
        let width = self.size.width
        let height = self.size.height
        
        return height != 0 ? width / height : nil
    }
}
