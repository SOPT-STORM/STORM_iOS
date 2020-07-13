//
//  EndProjectPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class EndProjectPopViewController: UIViewController {
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var endProjectPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        endProjectPopView.layer.cornerRadius = 15
        endProjectPopView.addShadow(width: 1, height: 3, 0.2, 5)
        endProjectPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func endConfirmButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    @IBAction func endCancelButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
            self.view.alpha = 0.0;
        }, completion: {(finished : Bool)   in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
