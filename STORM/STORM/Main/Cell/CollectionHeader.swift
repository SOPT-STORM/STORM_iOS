//
//  CollectionHeader.swift
//  STORM
//
//  Created by 김지현 on 2020/07/18.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollectionHeader: UICollectionReusableView {
        
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDateLabel: UILabel!
    @IBOutlet weak var projectRoundNumLabel: UILabel!
    @IBOutlet weak var scrappedCollectionView: UICollectionView!
    
}

extension CollectionHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row / 2 == 1 {
            let scrappedCardTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Scrapped Card Text Cell", for: indexPath) as! ScrappedCardTextCell
            scrappedCardTextCell.scrappedTextLabel.text = "adadfadfadff"
             return scrappedCardTextCell
        }
        else {
            let scrappedCardImgaeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Scrapped Card Image Cell", for: indexPath) as! ScrappedCardImageCell
            scrappedCardImgaeCell.scrappedImage.image = UIImage(named: "testImg")
            
             return scrappedCardImgaeCell
        }
    }
    
    
}
