//
//  MemoCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/15.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class MemoCell: UICollectionViewCell {
    
    lazy var cellIndex: Int = 0
    lazy var cardIndex: Int? = 0
    lazy var isScrapped: Bool = false
    var cancelBlock: (() -> Void)? = nil
    var scrapBlock: (() -> Void)? = nil
    
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var shadowRoundedView: UIView!
    
    @IBAction func didPressHeart(_ sender: UIButton) {
        if isScrapped == false {
            
            guard let idx = cardIndex else {return}
            NetworkManager.shared.scrapCard(cardIdx: idx) { (response) in
                let heartFillImage = UIImage(systemName: "heart.fill")
                sender.setImage(heartFillImage, for: .normal)
                sender.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                self.isScrapped = true
                self.scrapBlock?()
            }
        } else {
            
            guard let idx = cardIndex else {return}
            NetworkManager.shared.cancelScrap(cardIdx: idx) { (response) in
                let heartImage = UIImage(systemName: "heart")
                sender.setImage(heartImage, for: .normal)
                sender.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                self.isScrapped = false
                self.cancelBlock?()
            }
        }
    }
    
    override func prepareForReuse() {
        heartBtn.setImage(nil, for: .normal)
    }
}
