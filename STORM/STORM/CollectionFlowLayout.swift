//
//  CollectionFlowLayout.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollectionViewGridLayout: UICollectionViewFlowLayout {
    
    
    init(itemSize: CGSize) {
        super.init()
//        self.numberOfColumns = numberofColumns
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 50
        self.minimumLineSpacing = 20
//        self.scrollDirection = .horizontal
        self.scrollDirection = .vertical
        
        self.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init fail")
    }
    
    override var itemSize: CGSize {
        get{
//            if let collectionView = collectionView {
//                let collectionViewWidth = collectionView.frame.width
//                let itemWidth = (collectionViewWidth/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
//                let itemHeight: CGFloat = itemWidth
//                return CGSize(width: itemWidth, height: itemHeight)
//            }
            return CGSize(width: 128, height: 140)
        }
        set{
            super.itemSize = newValue
        }
    }
}


