//
//  OneLineMessagePopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class OneLineMessagePopViewController: UIViewController {

    @IBOutlet weak var invalidCodePopView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = message
        
        invalidCodePopView.layer.cornerRadius = 15
        invalidCodePopView.clipsToBounds = true
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func okButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
