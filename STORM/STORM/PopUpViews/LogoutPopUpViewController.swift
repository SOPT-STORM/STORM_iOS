//
//  LogoutPopUpViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class LogoutPopUpViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var popUpView: UIView!
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.roundCorners(corners: .allCorners, radius: 15.0)
    }
    
    // MARK:- IBAction
    
    @IBAction func logoutButtonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutCancelDidTap(_ sender: UIButton) {
        
    }
    
}
