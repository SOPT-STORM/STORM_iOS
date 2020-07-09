//
//  CardCollectionViewCell.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cardCollectionViewCell"

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var scrapButton: UIButton!
    
    var didScrap: (() -> Void)?
    
    var isScrap: Bool = false {
        didSet {
            let image = isScrap ? UIImage(named: "roundviewScrollUnselectedBtnHeart2") : UIImage(named: "roundviewBtnHeart2")
            scrapButton.setImage(image, for: .normal)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func cardButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func scrapButtonDidPress(_ sender: UIButton) {
        isScrap = !isScrap
        didScrap?()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.dropShadow(color: .black, opacity: 0.2, offSet: (CGSize(width: 0, height: 3)), radius: 7, scale: true)
        cardView.setRadius(radius: 15)
    }

}
