//
//  FinalViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class FinishedRoundViewController: UIViewController, UICollectionViewDelegate {


    @IBOutlet weak var roundCollectionView: UICollectionView!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - IBAction
    
    @IBAction func myPageButtonDidPress(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCollectionView.register(UINib(nibName: "RoundCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RoundCollectionViewCell.identifier)
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        cardListCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cardListCollectionView.delegate = self
        cardListCollectionView.dataSource = self
        self.navigationController?.setNaviBar()
        roundCollectionView.clipsToBounds = true

    }

}


extension FinishedRoundViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
        return 5
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as! RoundCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
            return cell
        }
        
    }
    
}

extension FinishedRoundViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            return CGSize(width: roundCollectionView.frame.width, height: roundCollectionView.frame.height)
        } else {
            return CGSize(width: cardListCollectionView.frame.width, height: cardListCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 0 {
            return 0
        } else {
            return 28
        }
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                } else {
                    return UIEdgeInsets(top: 28, left: 27, bottom: 0, right: 27)
                }

}
}
