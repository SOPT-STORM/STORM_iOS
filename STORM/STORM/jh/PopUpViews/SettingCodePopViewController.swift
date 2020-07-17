//
//  SettingCodePopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SettingCodePopViewController: UIViewController {
    
    // MARK:- 변수 선언

    @IBOutlet weak var settingCodePopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingCodePopView.layer.cornerRadius = 15
//        settingCodePopView.addShadow(width: 1, height: 3, 0.2, 5)
        settingCodePopView.addRoundShadow(cornerRadius: 15)
        settingCodePopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func createOkButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    

}
