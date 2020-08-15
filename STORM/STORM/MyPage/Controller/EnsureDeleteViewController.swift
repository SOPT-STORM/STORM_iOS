//
//  EnsureDeleteViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/05.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class EnsureDeleteViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 디자인
        self.setNaviTitle()
        self.view.tintColor = .stormRed
        
        whiteView.roundCorners(corners: [.topRight, .topLeft], radius: 30.0)
        
        deleteAccountButton.addShadow(cornerRadus: 7, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 2)
    }

}
