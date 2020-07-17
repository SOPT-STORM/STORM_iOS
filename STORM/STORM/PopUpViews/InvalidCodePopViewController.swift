//
//  InvalidCodePopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class InvalidCodePopViewController: UIViewController {
    
    static let identifier = "InvalidCodePopViewController"
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var invalidCodePopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        invalidCodePopView.layer.cornerRadius = 15
//        invalidCodePopView.addShadow(width: 1, height: 3, 0.2, 5)
//        invalidCodePopView.addRoundShadow(cornerRadius: 15)
        invalidCodePopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func okButtonDidTap(_ sender: UIButton) {
        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    
}
