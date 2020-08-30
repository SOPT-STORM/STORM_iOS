//
//  EndProjectPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class EndProjectPopViewController: UIViewController {
    
   static let identifier = "EndProjectPopViewController"
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var endProjectPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        endProjectPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
     
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func endConfirmButtonDidTap(_ sender: UIButton) {
       
    }
    
    @IBAction func endCancelButtonDidTap(_ sender: UIButton) {
      
    }
    
    // MARK:- 함수 선언
    

}
