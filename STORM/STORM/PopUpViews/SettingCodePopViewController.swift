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
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var copyButton: UIButton!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingCodePopView.layer.cornerRadius = 15
        //settingCodePopView.addRoundShadow(cornerRadius: 15)
        settingCodePopView.clipsToBounds = true
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        copyButton.cornerRadius = 4.0
        
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func createOkButtonDidTap(_ sender: UIButton) {
        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    

}
