//
//  DrawingCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/15.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DrawingCell: UICollectionViewCell {
    
    lazy var index: Int? = 0
    
    @IBOutlet weak var drawingImgView: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var shadowView: UIView!
    
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
        shadowView.addRoundShadow(contentView: drawingImgView, cornerRadius: 15)
    }
    
}


