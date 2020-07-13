//
//  FinalViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import FlexiblePageControl

class FinishedRoundViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var roundCollectionView: UICollectionView!
    @IBOutlet weak var cardListCollectionView: UICollectionView!

    @IBOutlet weak var pageControl: FlexiblePageControl!
    
    
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
        roundCollectionView.setRadius(radius: 15)
        roundCollectionView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 3)
        roundCollectionView.clipsToBounds = true
        roundCollectionView.indicatorStyle = .white
        
        // MARK: - Page Control 라이브러리 연결
        
        // color
        pageControl.pageIndicatorTintColor = UIColor.bgPageControlColor
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        // size
        let config = FlexiblePageControl.Config(
            displayCount: 7,
            dotSize: 6,
            dotSpace: 4,
            smallDotSizeRatio: 0.5,
            mediumDotSizeRatio: 0.7
        )
        pageControl.setConfig(config)

    }
}




extension FinishedRoundViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            let count = 10
            // TODO: 서버통신 구현하면 다시 재조정하기
            // https://stackoverflow.com/questions/47745936/how-to-connect-uipagecontrol-to-uicollectionview-swift/47746060
            
            pageControl.numberOfPages = count
            
            return count
            
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
            return 27
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 27, left: 27, bottom: 0, right: 27)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.setProgress(contentOffsetX: scrollView.contentOffset.x, pageWidth: scrollView.bounds.width)
    }
    
}


