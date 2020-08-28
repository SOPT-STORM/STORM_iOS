//
//  RoundCollectionViewCell.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var roundIndexLabel: UILabel!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    @IBOutlet weak var participantsProfile: UIStackView!
    
    @IBOutlet weak var participantsStackViewWidth: NSLayoutConstraint!
    
    var isUpdate: Bool = false
    
    lazy var participants: [Member] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        
        if isUpdate == false {

            addProfileImage(members: participants)
            
            if participants.count > 5 {
                let extraParticipants = participants.count - 5
                
                let participantsCountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: participantsProfile.frame.size.height, height: participantsProfile.frame.size.height))
                
                participantsCountLabel.text = "+\(extraParticipants)"
                participantsCountLabel.translatesAutoresizingMaskIntoConstraints = false
                participantsProfile.addArrangedSubview(participantsCountLabel)
                
                let width = CGFloat(7*5) + participantsProfile.frame.size.height * 6
                
                participantsStackViewWidth.constant = width
            }
            
            if !participants.isEmpty{
            isUpdate = true
            }
        }
    }
    
    func addProfileImage(members:[Member]) {
        
        var count = 0
        
        for member in members {
            
            let url = member.user_img
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: participantsProfile.frame.size.height, height: participantsProfile.frame.size.height))
            
            guard let imageURL = URL(string: url) else {return}
            
            imageView.kf.setImage(with: imageURL)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false

            participantsProfile.addArrangedSubview(imageView)
            
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.layer.masksToBounds = true
            
            count += 1
            
            if count == members.count || count >= 5 {
                let width = CGFloat(7*(count-1)) + participantsProfile.frame.size.height * CGFloat(count)
                
                participantsStackViewWidth.constant = width
                
                break
            }
        }
    }

}
