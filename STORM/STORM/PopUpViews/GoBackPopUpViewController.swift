//
//  GoBackPopUpViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/19.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class GoBackPopUpViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 15
        popUpView.clipsToBounds = true
    }
    
    @IBAction func okButtonDidTap(_ sender: UIButton) {
        NotificationCenter.default.post(
        name: NSNotification.Name(rawValue: "OKButton"),
        object: nil)
        self.dismiss(animated: false, completion: nil)
    }
        
    
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    

}
