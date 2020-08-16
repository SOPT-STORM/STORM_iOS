//
//  DrawingCarouselCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DrawingCarouselCell: UICollectionViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var drawingImgView: UIImageView!
    
    @IBAction func didPressHeartBtn(_ sender: UIButton) {
        if sender.imageView!.image ==  UIImage(named: "btn_heart") {
            sender.setImage(UIImage(named: "btn_heart_fill"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "btn_heart"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImgView.layer.cornerRadius = userImgView.frame.width / 2
        shadowView.addRoundShadow(contentView: drawingImgView , cornerRadius: 15)
    }
}
