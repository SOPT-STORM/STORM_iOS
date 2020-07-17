//
//  SelectNextPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SelectNextPopViewController: UIViewController {
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var selectNextPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectNextPopView.layer.cornerRadius = 15
//        selectNextPopView.addShadow(width: 1, height: 3, 0.2, 5)
        //selectNextPopView.addRoundShadow(cornerRadius: 15)
        selectNextPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func cancelNextButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언

}
