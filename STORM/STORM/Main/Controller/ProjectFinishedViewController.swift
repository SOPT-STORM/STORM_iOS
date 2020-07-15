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
    
    @IBOutlet weak var projectDateLabel: UILabel!
    @IBOutlet weak var projectRoundCountLabel: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var projectInfoView: UIView!
    @IBOutlet weak var roundCollectionView: UICollectionView!
    @IBOutlet weak var scrappedCardCollectionView: UICollectionView!
    @IBOutlet weak var scrappedCardSlider: UISlider!
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        projectInfoView.addShadow(width: 1, height: 4, 0.3, 3)
        projectInfoView.cornerRadius = 15
        
        // MARK: COLLECTION VIEW
        
        scrappedCardCollectionView.delegate = self
        scrappedCardCollectionView.dataSource = self
        
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        
        scrappedCardCollectionView.tag = 1
        
        roundCollectionView.tag = 2
        
        setScrappedCardList()
        
        // MARK: 네비게이션 바 색, 로고
        self.navigationController?.setNavigationBar()
        
        // 슬라이더바
        scrappedCardSlider.thumbTintColor = .clear
        scrappedCardSlider.maximumTrackTintColor = UIColor(white: 1, alpha: 0.56)
        
        // MARK: Nib register
        roundCollectionView.register(UINib(nibName: "RoundCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: RoundCollectionViewCell.identifier)
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        roundCollectionView.clipsToBounds = false
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

extension ProjectFinishedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 2
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            guard let scrappedCardTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Scrapped Card Text Cell", for: indexPath) as? ScrappedCardTextCell else {
                 return UICollectionViewCell()
             }
            scrappedCardTextCell.text.text = textList?[indexPath.row]
             return scrappedCardTextCell
        }
        else {
            guard let roundCell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as? ScrappedCardImageViewCell else { return UICollectionViewCell()
            }
            return roundCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    } // 셀 좌우 간격 조정
}
