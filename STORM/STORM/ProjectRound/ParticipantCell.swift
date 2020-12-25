//
//  ParticipantCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/24.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
    }
}
