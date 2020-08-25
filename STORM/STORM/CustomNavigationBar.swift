//
//  CustomNavigationBar.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    override func popItem(animated: Bool) -> UINavigationItem? {
        return super.popItem(animated: false)
    }
}
