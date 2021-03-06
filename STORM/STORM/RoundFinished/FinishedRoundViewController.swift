//
//  FinalViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import FlexiblePageControl

class FinishedRoundViewController: UIViewController {
    
    lazy var roundsInfo: [RoundInfo] = []
    lazy var selectedIndex: Int = 0
    lazy var projectIndex: Int = 0
    lazy var cards: [Card] = []
    lazy var projectName = ""
    lazy var cellIndexPath = IndexPath()
    
    @IBOutlet weak var roundCollectionView: UICollectionView!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: FlexiblePageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundCollectionView.register(UINib(nibName: "RoundCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "roundCollectionViewCell")
        
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        
        roundCollectionView.setRadius(radius: 15)
        roundCollectionView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 3)
        roundCollectionView.clipsToBounds = true
        roundCollectionView.indicatorStyle = .white
        
        cardListCollectionView.delegate = self
        cardListCollectionView.dataSource = self
        
        pageControl.pageIndicatorTintColor = UIColor.bgPageControlColor
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        let config = FlexiblePageControl.Config(
            displayCount: 7,
            dotSize: 6,
            dotSpace: 4,
            smallDotSizeRatio: 0.5,
            mediumDotSizeRatio: 0.7
        )
        
        pageControl.setConfig(config)
        
        self.setNaviTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(back))
        
        guard let roundIndex = roundsInfo[selectedIndex].round_idx else {return}
        
        NetworkManager.shared.fetchCardList(projectIdx: projectIndex, roundIdx: roundIndex) { [weak self] (response) in
            
            guard let cardList = response?.data?.card_list else {return}
            self?.cards = cardList
            self?.cardListCollectionView.reloadData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let indexPath = IndexPath(row: self.cellIndexPath.row, section: 0)
            self.roundCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let roundIndex = roundsInfo[selectedIndex].round_idx else {return}
        
        NetworkManager.shared.fetchCardList(projectIdx: projectIndex, roundIdx: roundIndex) { [weak self] (response) in
            
            guard let cardList = response?.data?.card_list else {return}
            self?.cards = cardList
            self?.cardListCollectionView.reloadData()
        }
    }
}

extension FinishedRoundViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            pageControl.numberOfPages = roundsInfo.count
            return roundsInfo.count
        } else {
            return cards.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundCollectionViewCell", for: indexPath) as! RoundCollectionViewCell
            
            guard let roundNumb = roundsInfo[indexPath.row].round_number, let roundTime = roundsInfo[indexPath.row].round_time, let roundParticipants = roundsInfo[indexPath.row].round_participant else {return cell}
            
            cell.projectNameLabel.text = projectName
            cell.roundGoalLabel.text = roundsInfo[indexPath.row].round_purpose
            cell.roundIndexLabel.text = "ROUND \(roundNumb)"
            cell.timeLimitLabel.text = "총 \(roundTime)분 소요"
            cell.participants = roundParticipants
            
            return cell
        } else {
            let card = cards[indexPath.row]
            
            if card.card_img != nil {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
                
                guard let url = card.card_img,let imageURL = URL(string: url) else {return UICollectionViewCell()}
                
                cell.drawingImgView.kf.setImage(with: imageURL)
                cell.cardIndex = card.card_idx
                
                if card.scrap_flag == 1 {
                    cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    cell.heartBtn.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                    cell.isScrapped = true
                } else {
                    cell.heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                    cell.heartBtn.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                    cell.isScrapped = false
                }
                
                cell.scrapBlock = {self.cards[indexPath.row].scrap_flag = 1}
                cell.cancelBlock = {self.cards[indexPath.row].scrap_flag = 0}
                
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
                
                cell.memo.text = card.card_txt!
                cell.cardIndex = card.card_idx
                
                if card.scrap_flag == 1 {
                    cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    cell.heartBtn.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                    cell.isScrapped = true
                } else {
                    cell.heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                    cell.heartBtn.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                    cell.isScrapped = false
                }
                
                
                cell.scrapBlock = {self.cards[indexPath.row].scrap_flag = 1}
                cell.cancelBlock = {self.cards[indexPath.row].scrap_flag = 0}
                
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            return CGSize(width: roundCollectionView.frame.width, height: roundCollectionView.frame.height)
        } else {
            let width = self.view.frame.width * 0.392
            return CGSize(width: width, height: width * 1.075)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            let inset = self.view.frame.width * 0.072
            return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 0 {
            return 0
        } else {
            return self.view.frame.width * 0.072
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "RoundFinished", bundle: nil).instantiateViewController(withIdentifier: "cardDetailViewController") as? CardDetailViewController, collectionView == cardListCollectionView, let roundNumb = roundsInfo[selectedIndex].round_number, let roundTime = roundsInfo[selectedIndex].round_time, let roundPurpose = roundsInfo[selectedIndex].round_purpose, let roundIndex = roundsInfo[selectedIndex].round_idx else {return}
        
        vc.roundIdx = roundIndex
        vc.projectIdx = projectIndex
        vc.index = indexPath.row
        vc.viewMode = .round
        vc.projectName = projectName
        vc.roundPurpose = roundPurpose
        vc.roundNumber = roundNumb
        vc.roundTime = roundTime
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.setProgress(contentOffsetX: scrollView.contentOffset.x, pageWidth: scrollView.bounds.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == roundCollectionView {
            guard let roundIndex = roundsInfo[pageControl.currentPage].round_idx else {return}
            
            self.selectedIndex = pageControl.currentPage
            
            NetworkManager.shared.fetchCardList(projectIdx: projectIndex, roundIdx: roundIndex) { [weak self] (response) in
                
                guard let cardList = response?.data?.card_list else {return}
                self?.cards = cardList
                self?.cardListCollectionView.reloadData()
            }
        }
    }
}




