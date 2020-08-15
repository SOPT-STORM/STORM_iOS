//
//  ProjectFinishedViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectFinishedViewController: UIViewController{
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var projectInfoView: UIView!
    
    @IBOutlet weak var scrapCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var roundCollectionView: UICollectionView!
    
    //MARK:- 변수
    
    //var scrapData: [Card] = []
    var roundData: [RoundInfo] = []
    
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shadow & radius
        projectInfoView.addShadow(cornerRadus: 15.0, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.16, shadowRadius: 4)
        
        // delegate & tag
        scrapCollectionView.delegate = self
        scrapCollectionView.dataSource = self
        scrapCollectionView.tag = 1
        
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        roundCollectionView.tag = 2
        
        //navigation bar
        self.setNaviTitle()
        
        //reload data
        scrapCollectionView.reloadData()
        roundCollectionView.reloadData()
    }
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == self.scrollView || scrollView == self.roundCollectionView) {
            
            let collectionViewPosition = self.roundCollectionView.contentOffset.y
            let scrollViewBottomEdge = self.scrollView.contentOffset.y + self.scrollView.frame.height

            if (scrollViewBottomEdge >= self.scrollView.contentSize.height) {
                
                self.scrollView.isScrollEnabled = false
                self.roundCollectionView.isScrollEnabled = true
                
            } else if (collectionViewPosition <= 0.0 && self.roundCollectionView.isScrollEnabled) {
                
                self.scrollView.scrollRectToVisible(self.scrollView.frame, animated: true)

                self.scrollView.isScrollEnabled = true
                self.roundCollectionView.isScrollEnabled = false
                
            }
        }
    }*/

}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource

extension ProjectFinishedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
            case 1 :
                return 10 //scrapData.count
        default:
            return 10 //roundData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //let scrapData = self.scrapData[indexPath.row]
        //let roundData = self.roundData[indexPath.row]


//        scrapCell.addRoundShadow(cornerRadius: 10)
//        roundCell.addRoundShadow(cornerRadius: 10)
        
        //roundCell.roundNumberLabel.text = "ROUND \(roundData.round_number)"
        //roundCell.roundPurposeLabel.text = roundData.round_purpose
        //roundCell.roundTimeLabel.text = "총 \(roundData.round_time)분 소요"
        
        switch collectionView.tag {
            case 1 :
                let scrapCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrapCardCell", for: indexPath) as! ScrapCardCell
                scrapCell.addRoundShadow(cornerRadius: 10)

                return scrapCell
        default:
            let roundCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCardCell", for: indexPath) as! RoundCardCell
                roundCell.addRoundShadow(cornerRadius: 10)
                return roundCell
        }

        /*
        if scrapData.card_txt == nil {
            scrapCell.addDrawingImg(url: URL(string: scrapData.card_img!)!, index: scrapData.card_idx!)
        } else {
            scrapCell.addMemo(text: scrapData.card_txt!, index: scrapData.card_idx!)
        }
 */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
        case 1:
            let width = self.view.frame.width * 0.373
            return CGSize(width: width, height: width * 1.071)
        default:
            let width = self.view.frame.width
            return CGSize(width: width, height: width * 2.678)
        }
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
 
