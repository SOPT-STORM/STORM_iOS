//
//  MemoCarouselCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class MemoCarouselCell: UICollectionViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contetnt: UIView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func didPressHeartBtn(_ sender: UIButton) {
        if sender.imageView!.image ==  UIImage(named: "btn_heart") {
            sender.setImage(UIImage(named: "btn_heart_fill"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "btn_heart"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        shadowView.addRoundShadow(contentView: contetnt, cornerRadius: 15)
        
    }
}
