//
//  AllRoundViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class AllRoundViewController: UIViewController {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var roundNumberLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var cardAdditionImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardList: [addedCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let time = ProjectSetting.shared.roundTime
        TimeManager.shared.endTime = Date.init(timeIntervalSinceNow: time * 60)
        setProjectInfo()
        
        self.setNaviTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TimeManager.shared.makeAndFireTimer { (endTime) in
            let startTime = Date(timeIntervalSinceNow: 0)
            let time = Int(endTime.timeIntervalSince(startTime))
            
            if time >= 0 {
                let minute = time/60
                let second = time - minute*60
                self.timeLimitLabel.text = String(format: "총 %02d:%02d 남음", minute, second)
            }
            
            if time <= 0 {
                TimeManager.shared.invalidateTimer()
                
                let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
                
                let vc = storyboard.instantiateViewController(withIdentifier: "roundFinishedPopup") as! RoundFinishedPopup
                vc.delegate = self
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: false, completion: nil)
            }
        }
        
        if cardList.count != 0 {
            cardAdditionImg.isHidden = true
        }else{
            cardAdditionImg.isHidden = false
        }
        
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TimeManager.shared.invalidateTimer()
    }
    
    @IBAction func didPressCardAddition(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ProjectRound", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "addCardViewController") as? AddCardViewController else { return }
        vc.projectName = self.projectNameLabel.text!
        vc.round = self.roundNumberLabel.text!
        vc.roundGoal = self.roundGoalLabel.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setProjectInfo() {
        let projectSetting = ProjectSetting.shared
        
        guard let roundNumb = projectSetting.roundNumb else {return}
        
        self.roundNumberLabel.text = "ROUND \(roundNumb)"
        self.roundGoalLabel.text = projectSetting.roundPurpose
        self.projectNameLabel.text = projectSetting.projectName
    }
}

extension AllRoundViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = cardList[indexPath.row]
        
        if card.card_drawing != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
            
            cell.drawingImgView.image = card.card_drawing
            cell.heartBtn.isHidden = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
            
            cell.memo.text = card.card_text
            cell.heartBtn.isHidden = true
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

extension AllRoundViewController: PresentDelegate {
    func presentVC() {
        if let roundMeetingVC = UIStoryboard(name: "ProjectRound", bundle: nil).instantiateViewController(withIdentifier: "roundMeetingVC") as? RoundMeetingViewController {
            
            let naviController = UINavigationController(rootViewController: roundMeetingVC)
            naviController.modalPresentationStyle = .fullScreen
            
            self.present(naviController, animated: false, completion: nil)
        }
    }
}
