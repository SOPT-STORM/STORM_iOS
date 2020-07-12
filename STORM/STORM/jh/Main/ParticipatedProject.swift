//
//  ParticipatedProject.swift
//  STORM
//
//  Created by 김지현 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import Foundation

struct ParticipatedProject {
    var cardImg1: UIImage?
    var cardImg2: UIImage?
    var cardImg3: UIImage?
    var cardImg4: UIImage?
    var projectTitle: String
    init(title: String, cardImageName1: String, cardImageName2: String, cardImageName3: String, cardImageName4: String ) {
        self.cardImg1 = UIImage(named: cardImageName1)
        self.cardImg2 = UIImage(named: cardImageName2)
        self.cardImg3 = UIImage(named: cardImageName3)
        self.cardImg4 = UIImage(named: cardImageName4)
        self.projectTitle = title
    }
}
