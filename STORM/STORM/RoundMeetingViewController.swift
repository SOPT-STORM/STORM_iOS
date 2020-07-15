//
//  CollecViewController5.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundMeetingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.setNaviTitle()
    }
}

extension RoundMeetingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row / 2 == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
            cell.memo.text = "샬라 샬라 샬라 샬라 샬라라라랄라라라랄라라라라라라라라라랄"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
            cell.drawingImg.image = UIImage(named: "testImg")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.392
        return CGSize(width: width, height: width * 1.075)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let inset = self.view.frame.width * 0.072
       return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
}


