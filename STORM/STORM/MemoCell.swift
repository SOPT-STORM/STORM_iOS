//
//  MemoCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/15.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class MemoCell: UICollectionViewCell {
    
    lazy var index: Int? = 0
    
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var shadowRoundedView: UIView!
    
    @IBAction func didPressHeart(_ sender: UIButton) {

        if sender.imageView!.image ==  UIImage(named: "btn_heart") {
            sender.setImage(UIImage(named: "btn_heart_fill"), for: .normal)
            
            guard let idx = index else {return}
            NetworkManager.shared.scrapCard(cardIdx: idx) { (response) in
                print(response)
            }
        } else {
            sender.setImage(UIImage(named: "btn_heart"), for: .normal)
            
            guard let idx = index else {return}
            NetworkManager.shared.cancelScrap(cardIdx: idx) { (response) in
                print(response)
            }
        }
    }
    
    override func layoutSubviews() {
        self.shadowRoundedView.layer.cornerRadius = 15
        self.shadowRoundedView.layer.backgroundColor = UIColor.white.cgColor  //UIColor.clear.cgColor
        self.shadowRoundedView.layer.shadowColor = UIColor.black.cgColor
        self.shadowRoundedView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.shadowRoundedView.layer.shadowOpacity = 0.16 // 0.16
        self.shadowRoundedView.layer.shadowRadius = 3
        
        self.shadowRoundedView.layer.cornerRadius = 15
    }
}
