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
       var pressButton: (() -> Void)?

        override func viewDidLoad() {
            super.viewDidLoad()
            // self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            popupView.layer.opacity = 0.6
            roundStartAlertView.setRadius(radius: 15)
            roundStartAlertView.dropShadow(color: .darkGray, offSet: CGSize(width: 0, height: 3))
      
                
                // Do any additional setup after loading the view.
            }


            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            @IBAction func confirmButtonDidPress(_ sender: UIButton) {
                pressButton?()
         
            
         
            }
            
}

