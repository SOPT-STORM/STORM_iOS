//
//  CALayer.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension CALayer {
   func roundCorners(radius: CGFloat) {
       let roundPath = UIBezierPath(
           roundedRect: self.bounds,
           cornerRadius: radius)
       let maskLayer = CAShapeLayer()
       maskLayer.path = roundPath.cgPath
       self.mask = maskLayer
   }
}
