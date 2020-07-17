//
//  RoundEndPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundEndPopViewController: UIViewController {
    
    static let identifier = "RoundEndPopViewController"
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var roundEndPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        roundEndPopView.layer.cornerRadius = 15
        roundEndPopView.addShadow(width: 1, height: 3, 0.2, 5)
        roundEndPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func roundEndOkButtonDidTap(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    // MARK:- 함수 선언
    

}
