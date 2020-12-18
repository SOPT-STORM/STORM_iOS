//
//  ProjectInfoCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/18.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Kingfisher

class ProjectInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var projectName: UILabel!
    
    @IBOutlet weak var roundInfo: UILabel!
    
    @IBOutlet weak var participantsProfile: UIStackView!
    
    @IBOutlet weak var participantsCount: UILabel!
    
    lazy var participants: [String] = []
    
    @IBOutlet weak var participantsStackViewWidth: NSLayoutConstraint!
    
    var isUpdate: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        
        if isUpdate == false {
            
            if participants.count <= 5 {
                participantsCount.isHidden = true
            } else {
                participantsCount.isHidden = false
                let extraParticipants = participants.count - 5
                participantsCount.text = "+\(extraParticipants)"
            }
            
            addProfileImage(imgURLs: participants)
            
            if !participants.isEmpty{
                isUpdate = true
            }
        }
    }
    
    func addProfileImage(imgURLs:[String]) {
        
        var count = 0
        
        for url in imgURLs {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: participantsProfile.frame.size.height, height: participantsProfile.frame.size.height))
            
            guard let imageURL = URL(string: url) else {return}
            
            imageView.kf.setImage(with: imageURL)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            participantsProfile.addArrangedSubview(imageView)
            
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.layer.masksToBounds = true
            
            count += 1
            
            if count == imgURLs.count || count >= 5 {
                let width = CGFloat(7*(count-1)) + participantsProfile.frame.size.height * CGFloat(count)
                
                participantsStackViewWidth.constant = width
                
                break
            }
        }
    }
}
