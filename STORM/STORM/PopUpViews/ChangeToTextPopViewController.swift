//
//  ChangeToTextPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ChangeToTextPopViewController: UIViewController {
    
    static let identifier = "ChangeToTextPopViewController"
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var changeToTextPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeToTextPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

    }
}
