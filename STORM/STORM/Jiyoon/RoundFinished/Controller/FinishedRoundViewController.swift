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
    
    //    let projectIndex = UserDefaults.standard.object(forKey: "projectIndex")
    
    var numberOfRounds = 0
    var numberOfCards = 0
    
    var cardInfos: ProjectInfo?
    
    
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
        getFinalRoundInfo()
        fetchCardList()
        
    }
    
    func getFinalRoundInfo() {
        NetworkManager.shared.fetchAllRoundInfo(projectIdx: 1) { (response) in
            print(response?.status)
            print(response?.message)
            print(response!.data!)
            self.numberOfRounds = response?.data!.count as! Int
            //            print("numberOfRounds: \(self.numberOfRounds)")
            self.roundCollectionView.reloadData()
            
        }
    }
    

    
    func fetchCardList() {
        NetworkManager.shared.fetchCardList(projectIdx: 1, roundIdx: 1) { (response) in
            print(response?.message)
            self.numberOfCards = response?.data?.card_list.count as! Int
            print("카드 수: \(self.numberOfCards)")
            print(response!.data!)
            self.cardListCollectionView.reloadData()

        }
    }
    
}

extension FinishedRoundViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            
            pageControl.numberOfPages = self.numberOfRounds
            
            return self.numberOfRounds
            
        } else {
            
            return self.numberOfCards
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as! RoundCollectionViewCell
            
//            var projectInfo: ProjectInfo? {
//                didSet {
//                    cell.projectNameLabel.text = projectInfo?.project_name
//                    cell.roundGoalLabel.text = projectInfo?.round_purpose
//                    cell.timeLimitLabel.text = "총 \(projectInfo?.round_time)분 소요"
//                    cell.roundIndexLabel.text = "ROUND\(projectInfo?.round_number)"
//                }
//            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
            if cardInfos?.card_list[indexPath.row].card_img == nil {
                print("card_img is nill")
                cell.cardImage.isHidden = true
                cell.cardLabel.isHidden = false
                cell.cardLabel.text = "\(String(describing: cardInfos?.card_list[indexPath.row].card_txt!))"
            }
            else {
                print("card_text is nill")
                cell.cardLabel.isHidden = true
                //                cell.cardImage.image = cardInfos?.card_list[indexPath.row].card_txt
            }
            
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


