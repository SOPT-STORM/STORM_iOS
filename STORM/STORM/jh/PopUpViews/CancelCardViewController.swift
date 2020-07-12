//
//  CancelCardViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CancelCardViewController: UIViewController {

    @IBOutlet weak var cancelCardPopView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cancelCardPopView.layer.cornerRadius = 15
        cancelCardPopView.addShadow(width: 1, height: 3, 0.2, 5)
        cancelCardPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    @IBAction func cardCancelButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    @IBAction func cardConfirmButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
