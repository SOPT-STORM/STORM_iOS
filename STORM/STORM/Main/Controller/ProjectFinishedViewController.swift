//
//  ProjectFinishedViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectFinishedViewController: UIViewController {
    
    // MARK:- 변수 선언
    
    private var textList: [String]?
    private var imageList: [UIImage]?
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var roundCollectionView: UICollectionView!
    
    /*
    @IBAction func sliderAction(_ sender: UISlider) {
        self.scrappedCardCollectionView.contentOffset.x += CGFloat(sender.value)
    }
    */
    
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: HEADER
        
       roundCollectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")
        
        
        
        // MARK: COLLECTION VIEW ROUND
        
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        
        //reusableView.scrapCardCollectionView.tag = 1
        roundCollectionView.tag = 2
        
        
        // MARK: 네비게이션 바 색, 로고
        self.navigationController?.setNavigationBar()
        
        /*
        // 슬라이더바
        scrappedCardSlider.thumbTintColor = .clear
        scrappedCardSlider.maximumTrackTintColor = UIColor(white: 1, alpha: 0.56)
        */
        
        // MARK: Nib register
        roundCollectionView.register(UINib(nibName: "RoundCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: RoundCollectionViewCell.identifier)
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        roundCollectionView.clipsToBounds = false
        
        roundCollectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")
    }
}

// MARK:- COLLECTION VIEW

extension ProjectFinishedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView.tag {
//        case 1:
//            return 9
//        default:
//            return 5
//        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
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
        else {
            guard let roundCell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as? RoundCollectionViewCell else { return UICollectionViewCell()
            }
            return roundCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.2933
        return CGSize(width: width, height: width * 1.0909)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let rlInset = self.view.frame.width * 0.08
       let tbInset = self.view.frame.width * 0.0213
        
        return UIEdgeInsets(top: 1.5, left: rlInset, bottom: 1.5, right: rlInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.034
    }
    
    // MARK:- REUSABLE VIEW
       
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           switch kind {
           case UICollectionView.elementKindSectionHeader:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "resuableView", for: indexPath) as! ReusableView
               
               // MARK: INFO VIEW
            print("1  \(reusableView)", "2   \(reusableView.projectInfoView)")

//               reusableView.projectInfoView.addShadow(width: 1, height: 4, 0.3, 3)
               reusableView.projectInfoView.cornerRadius = 15
               
               // MARK: COLLECTION VIEW SCRAP
               
               reusableView.scrapCardCollectionView.delegate = self
               reusableView.scrapCardCollectionView.dataSource = self
               
               return reusableView
           default:
               assert(false, "")
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           let width: CGFloat = collectionView.frame.width
           let height: CGFloat = width * 1.392
           return CGSize(width: width, height: height)
    }
}
