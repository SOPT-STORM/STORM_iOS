//
//  UIColor+Extensions.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

  @nonobjc class var stormYellow: UIColor {
    return UIColor(red: 245.0 / 255.0, green: 202.0 / 255.0, blue: 110.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var placeholderColor: UIColor {
    return UIColor(white: 152.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var textDefaultColor: UIColor {
    return UIColor(white: 112.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var stormRed: UIColor {
    return UIColor(red: 236.0 / 255.0, green: 101.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var bgPageControlColor: UIColor {
    return UIColor(red: 245.0 / 255.0, green: 178.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)
  }

}
