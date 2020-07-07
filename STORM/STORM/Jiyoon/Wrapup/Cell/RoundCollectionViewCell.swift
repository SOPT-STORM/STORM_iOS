//
//  RoundCollectionViewCell.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundCollectionViewCell: UICollectionViewCell {

    
    static let identifier : String = "roundCollectionViewCell"
    
    
    @IBOutlet weak var roundIndexLabel: UILabel!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet var profileImageView: [UIImageView]!
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
