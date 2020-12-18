//
//  LayerExtension.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension UIView {
    
    func dropShadow(color: UIColor, opacity: Float = 0.16, offSet: CGSize, radius: CGFloat = 3) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.masksToBounds = false
        
    }
    
    func setRadius(radius: CGFloat, scale: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
}
