//
//  RoundFinishedViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundFinishedViewController: UIViewController {
    
    // MARK:- 변수 선언
    
    private var textList: [String]?
    private var imageList: [UIImage]?
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var projectDateLabel: UILabel!
    @IBOutlet weak var projectRoundCountLabel: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var projectInfoView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var roundCollectionView: UICollectionView!
    @IBOutlet weak var scrappedCardCollectionView: UICollectionView!
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        projectInfoView.addShadow(width: 1, height: 4, 0.3, 3)
        projectInfoView.addRoundShadow(cornerRadius: 15)
//        projectInfoView.cornerRadius = 15
        
        // MARK: COLLECTION VIEW
        
        scrappedCardCollectionView.delegate = self
        scrappedCardCollectionView.dataSource = self
        
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        
        scrappedCardCollectionView.tag = 1
        
        roundCollectionView.tag = 2
        
        setScrappedCardList()
    }
    
    // MARK:- 함수 선언
    
    private func setScrappedCardList() {
        let card1 = "날개 달린 마스크"
        let card2 = "파파고 기능 마스크"
        
        guard let card3 = UIImage(named: "roundViewUser1") else {return}
        guard let card4 = UIImage(named: "roundViewUser2") else {return}
        
        textList = [card1, card2]
        imageList = [card3, card4]
    }
}

// MARK:- COLLECTION VIEW

extension RoundFinishedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 2
        default:
            return imageList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            guard let scrappedCardTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Scrapped Card Text Cell", for: indexPath) as? ScrappedCardTextCell else {
                return UICollectionViewCell()
            }
            scrappedCardTextCell.text.text = textList?[indexPath.row]
            return scrappedCardTextCell
            
        default:
            guard let scrappedCardImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Scrapped Card Text Cell", for: indexPath) as? ScrappedCardImageViewCell else { return UICollectionViewCell()
            }
            
            scrappedCardImageCell.image.image = imageList?[indexPath.row]
            return scrappedCardImageCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    } // 셀 좌우 간격 조정
}

