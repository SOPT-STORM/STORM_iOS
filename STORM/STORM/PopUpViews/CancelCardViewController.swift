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


        cancelCardPopView.layer.cornerRadius = 15

        cancelCardPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func cardCancelButtonDidTap(_ sender: UIButton) {
//        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        
    }
    
    @IBAction func cardConfirmButtonDidTap(_ sender: UIButton) {
//        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        
    }
    
    
    

}
