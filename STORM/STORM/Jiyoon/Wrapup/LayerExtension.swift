//
//  LayerExtension.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension UIView {

func dropShadow(color: UIColor, opacity: Float = 0.2, offSet: CGSize, radius: CGFloat = 5, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
}
    
    func setRadius(radius: CGFloat, scale: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
    }
    
}
