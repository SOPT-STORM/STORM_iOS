//
//  AllRoundViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class AllRoundViewController: UIViewController {
    
    @IBOutlet weak var cardAdditionImg: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    @IBAction func didPressCardAddition(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allRoundViewController") as! AllRoundViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllRoundViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row / 2 == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
            cell.memo.text = "샬라 샬라 샬라 샬라 샬라라라랄라라라랄라라라라라라라라라랄"
            cell.heartBtn.isHidden = true
//            cell.addRoundShadow(cornerRadius: 10)
            cell.setRound(10)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
            cell.drawingImg.image = UIImage(named: "testImg")
            cell.heartBtn.isHidden = true
//            cell.addRoundShadow(cornerRadius: 10)
            cell.setRound(10)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.392
        return CGSize(width: width, height: width * 1.074)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let inset = self.view.frame.width * 0.072
       return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
    
    
}
