//
//  ChangeToDrawPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ChangeToDrawPopViewController: UIViewController {
    
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var changeToDrawPopView: UIView!
    
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeToDrawPopView.layer.cornerRadius = 15
        changeToDrawPopView.addShadow(width: 1, height: 3, 0.2, 5)
        changeToDrawPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    
    // MARK:- IBAction 선언
    
    /*
    @IBAction func cardCancelButtonDidTap(_ sender: UIButton) {
        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        self.removeAnimate()
    }
    
    @IBAction func cardConfirmButtonDidTap(_ sender: UIButton) {
        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        self.removeAnimate()
    }
    액션 명 정하기 어려워서 남겨둠
    */
    
    
    // MARK:- 함수 선언

}
