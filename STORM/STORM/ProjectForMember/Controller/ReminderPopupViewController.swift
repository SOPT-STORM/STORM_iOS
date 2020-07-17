//
//  ViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/06/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ReminderPopupViewController: UIViewController {

    static let identifier = "ReminderPopupViewController"
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var reminderView: UIView!
    
    lazy var box = UIView()



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        popupView.layer.opacity = 0.6
        reminderView.setRadius(radius: 15)
        reminderView.dropShadow(color: .darkGray, offSet: CGSize(width: 0, height: 3))
        self.showAnimate()
            
            // Do any additional setup after loading the view.
        }


        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func confirmButtonDidPress(_ sender: UIButton) {
            self.removeAnimate()
            self.dismiss(animated: true, completion: nil)
        
     
        }
        
    
    

}


