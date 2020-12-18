//
//  DrawingCarouselCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DrawingCarouselCell: UICollectionViewCell {
    
    var index: Int? = 0
    lazy var cellIndex: Int = 0
    lazy var isScrapped: Bool = false
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var drawingImgView: UIImageView!
    
    @IBOutlet weak var heartButton: UIButton!
    
    var cancelBlock: (() -> Void)? = nil
    var scrapBlock: (() -> Void)? = nil
    
    
    @IBAction func didPressHeartBtn(_ sender: UIButton) {
        if isScrapped == false {
            
            guard let idx = index else {return}
            NetworkManager.shared.scrapCard(cardIdx: idx) { (response) in
                let heartFillImage = UIImage(systemName: "heart.fill")
                sender.setImage(heartFillImage, for: .normal)
                sender.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                
                self.isScrapped = true
                self.scrapBlock?()
            }
        } else {
            
            guard let idx = index else {return}
            NetworkManager.shared.cancelScrap(cardIdx: idx) { (response) in
                let heartImage = UIImage(systemName: "heart")
                sender.setImage(heartImage, for: .normal)
                sender.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                
                self.isScrapped = false
                self.cancelBlock?()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImgView.layer.cornerRadius = userImgView.frame.width / 2
        shadowView.addRoundShadow(contentView: drawingImgView , cornerRadius: 15)
    }
}
