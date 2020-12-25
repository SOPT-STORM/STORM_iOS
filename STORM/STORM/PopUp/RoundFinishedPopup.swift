//
//  RoundFinishedPopup.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundFinishedPopup: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    var delegate: PresentVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.cornerRadius = 15
        self.contentView.clipsToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.dismiss(animated: false) {
                self.delegate.presentVC()
            }
        }
    }
}

