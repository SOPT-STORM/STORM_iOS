//
//  ProjectInfoCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/18.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectInfoCell: UICollectionViewCell {

    @IBOutlet weak var projectName: UILabel!
    
    @IBOutlet weak var roundInfo: UILabel!
    
    @IBOutlet weak var participantsProfile: UIStackView!
    
    @IBOutlet weak var participantsCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
