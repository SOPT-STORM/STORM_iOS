//
//  ReminderPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ReminderPopViewController: UIViewController {
    
    // MARK: - IBOutlet, 변수선언
    
    @IBOutlet weak var reminderView: UIView!
    
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



