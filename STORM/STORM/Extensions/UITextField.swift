//
//  UITextField.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension UITextField {
    func addTextFieldInset() {
        
    let insetWidth: CGFloat = 13
    let insetHeight: CGFloat = 13
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: insetWidth, height: insetHeight))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
        
  }
}
