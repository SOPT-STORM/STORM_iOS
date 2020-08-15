//
//  SortProjectViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SortProjectViewController: UIViewController {
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var whiteView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바
        self.setNaviTitle()
        self.view.tintColor = .stormRed
        
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
    }

}
