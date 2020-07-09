//
//  RoundStartAlertPopupViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundStartAlertPopupViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var roundStartAlertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundStartAlertView.setRound(15)
        roundStartAlertView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 0, height: 3), radius: 7.5, scale: true)
        roundStartAlertView.clipsToBounds = true
        

        // Do any additional setup after loading the view.
    }
    


}
