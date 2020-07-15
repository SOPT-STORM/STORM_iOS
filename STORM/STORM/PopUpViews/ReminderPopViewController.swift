//
//  ReminderPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ReminderPopViewController: UIViewController {

    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var reminderPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reminderPopView.layer.cornerRadius = 15
        reminderPopView.addShadow(width: 1, height: 3, 0.2, 5)
        reminderPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func remindOkButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    

}
