//
//  RecentProjectCardCollectionViewCell.swift
//  STORM
//
//  Created by 김지현 on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RecentProjectCardCollectionViewCell: UICollectionViewCell {
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var text4: UILabel!
    
    @IBOutlet weak var recentCardView: UIView!
    
    @IBOutlet weak var projectTitle: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    // MARK:- 변수 선언
    
    static let identifier: String = "Recent Project Cell"
    var present: (() -> ()) = {}
    
    // MARK:- 함수 선언
    
    
    @IBAction func ButtonDidTap(_ sender: Any) {
        present()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recentCardView.dropShadow(color: .black, opacity: 0.2, offSet: (CGSize(width: 0, height: 3)), radius: 3.5)
        recentCardView.setRadius(radius: 15)
        recentCardView.clipsToBounds = false
    
        
        heightConstraint.constant = 20
        heightConstraint.multiplier
    }
}
