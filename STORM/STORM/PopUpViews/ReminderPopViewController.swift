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

    
    // MARK: - IBOutlet, 변수선언
    
        @IBOutlet weak var reminderView: UIView!
//        var pressButton: (() -> Void)?
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            reminderView.setRadius(radius: 15)
            reminderView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3))
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()

        }
        
        @IBAction func confirmButtonDidPress(_ sender: UIButton) {

            self.dismiss(animated: false, completion: nil)

        }
        
        
    }



    // MARK:- viewDidLoad 선언
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        reminderPopView.layer.cornerRadius = 15
//        reminderPopView.addRoundShadow(cornerRadius: 15)
//        reminderPopView.clipsToBounds = true
//
//        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
//        self.showAnimate()
//    }
//
//    // MARK:- IBAction 선언
//    @IBAction func remindOkButtonDidTap(_ sender: UIButton) {
//        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
//        self.removeAnimate()
//    }
//
//    // MARK:- 함수 선언
    
    

