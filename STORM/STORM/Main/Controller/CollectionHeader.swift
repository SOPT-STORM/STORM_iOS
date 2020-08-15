//
//  CollectionHeader.swift
//  STORM
//
//  Created by 김지현 on 2020/08/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var projectInfoView: UIView!
    @IBOutlet weak var viewMoreButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .stormRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
