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
    
    // MARK: - IBAction
    
    @IBAction func cardButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func scrapButtonDidPress(_ sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 6.0
    }

}
