//
//  EndProjectPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class EndProjectPopViewController: UIViewController {
    
   static let identifier = "EndProjectPopViewController"
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var endProjectPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        endProjectPopView.layer.cornerRadius = 15
        endProjectPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
     
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func endConfirmButtonDidTap(_ sender: UIButton) {
       NotificationCenter.default.post(
       name: NSNotification.Name(rawValue: "ok"),
       object: nil)
       self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func endCancelButtonDidTap(_ sender: UIButton) {
      self.dismiss(animated: false, completion: nil)
    }
    
    // MARK:- 함수 선언
    

}
