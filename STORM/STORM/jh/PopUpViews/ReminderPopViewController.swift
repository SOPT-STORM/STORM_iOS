//
//  ReminderPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ReminderPopViewController: UIViewController {

    static let identifier = "ReminderPopViewController"
    
    // MARK: - IBOutlet, 변수선언
    
        @IBOutlet weak var reminderView: UIView!
//        var pressButton: (() -> Void)?
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            reminderView.setRadius(radius: 15)
            reminderView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3))
            self.showAnimate()
            
            // Do any additional setup after loading the view.
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func confirmButtonDidPress(_ sender: UIButton) {
//            pressButton?()
            self.removeAnimate()
            self.dismiss(animated: false, completion: nil)
            
            
        }
        
        
    }


