//
//  ProjectFinishFooterView.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/18.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectFinishFooterView: UICollectionReusableView {
    
    var delegate: PushVC!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didPressMoreScrappedCard(_ sender: UIButton) {
        self.delegate.pushVC()
    }
}
