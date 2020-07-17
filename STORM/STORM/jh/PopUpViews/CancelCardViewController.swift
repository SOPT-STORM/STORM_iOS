//
//  CancelCardViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CancelCardViewController: UIViewController {
    
    static let identifier = "CancelCardViewController"
    
    // MARK:- 변수 선언

    @IBOutlet weak var cancelCardPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cancelCardPopView.layer.cornerRadius = 15
        cancelCardPopView.addShadow(width: 1, height: 3, 0.2, 5)
        cancelCardPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func cardCancelButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    @IBAction func cardConfirmButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    

}
