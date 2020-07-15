//
//  ChangeToTextPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ChangeToTextPopViewController: UIViewController {
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var changeToTextPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeToTextPopView.layer.cornerRadius = 15
        changeToTextPopView.addShadow(width: 1, height: 3, 0.2, 5)
        changeToTextPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    /*
    @IBAction func cardCancelButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    @IBAction func cardConfirmButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    액션 명 정하는게 너무너무너무 어려워~~~~~
    */
    
    // MARK:- 함수 선언
    

}
