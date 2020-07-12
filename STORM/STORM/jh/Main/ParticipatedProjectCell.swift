//
//  ParticipatedProjectCell.swift
//  STORM
//
//  Created by 김지현 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ParticipatedProjectCell: UICollectionViewCell {
    @IBOutlet weak var projectTitle: UILabel!
    
    @IBOutlet weak var cardImage1: UIImageView!
    @IBOutlet weak var cardImage2: UIImageView!
    @IBOutlet weak var cardImage3: UIImageView!
    @IBOutlet weak var cardImage4: UIImageView!
    
    static let identifier: String = "Participated Project Cell"
    
    func set(_ projectInformation: ParticipatedProject) {
        cardImage1.image = projectInformation.cardImg1
        cardImage2.image = projectInformation.cardImg2
        cardImage3.image = projectInformation.cardImg3
        cardImage4.image = projectInformation.cardImg4
        projectTitle.text = projectInformation.projectTitle
    }
}
