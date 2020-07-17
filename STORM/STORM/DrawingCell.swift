//
//  DrawingCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/15.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DrawingCell: UICollectionViewCell {
    
    @IBOutlet weak var drawingImg: UIImageView!
    
    @IBAction func didPressHeart(_ sender: UIButton) {
        if sender.imageView!.image ==  UIImage(named: "btn_heart") {
            sender.setImage(UIImage(named: "btn_heart_fill"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "btn_heart"), for: .normal)
        }
    }
}


