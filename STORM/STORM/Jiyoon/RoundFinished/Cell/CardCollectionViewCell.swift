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
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    var didScrap: (() -> Void)?
    
    // TODO: 분기 처리 다시하기
    
    var isScrap: Bool = false {
        didSet {
            let image = isScrap ? UIImage(named: "roundviewScrollUnselectedBtnHeart2") : UIImage(named: "roundviewBtnHeart2")
            scrapButton.setImage(image, for: .normal)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func scrapButtonDidPress(_ sender: UIButton) {
        isScrap = !isScrap
        didScrap?()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.dropShadow(color: .black, opacity: 0.2, offSet: (CGSize(width: 0, height: 3)), radius: 3.5)
        cardView.setRadius(radius: 15)
    }
    
}
