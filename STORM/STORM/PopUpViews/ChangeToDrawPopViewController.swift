//
//  ChangeToDrawPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ChangeToDrawPopViewController: UIViewController {
    
    static let identifier = "ChangeToDrawPopViewController"
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var changeToDrawPopView: UIView!
    
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeToDrawPopView.layer.cornerRadius = 15
        changeToDrawPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
      
    }
    

}
