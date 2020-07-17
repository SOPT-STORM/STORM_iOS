//
//  AllRoundViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class AllRoundViewController: UIViewController {
    
    let projectIndex = UserDefaults.standard.integer(forKey: "projectIndex")
    
    var countdownTimer: Timer!
    var totalTime = 60
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var roundNumberLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var cardAdditionImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        fetchRoundInfo()
        fetchProjectName()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        cardAdditionImg.isHidden = true
        
        
        
    }
    
    @IBAction func didPressCardAddition(_ sender: UIButton) {
        
        let pushVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardViewController") as! AddCardViewController
        //        self.navigationController?.pushViewController(pushVC, animated: true)
        self.presentingViewController?.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    func fetchRoundInfo() {
        NetworkManager.shared.fetchRoundInfo(projectIdx: projectIndex) { (response) in
            self.roundNumberLabel.text = "ROUND\(response!.data!.round_number)"
            self.roundGoalLabel.text = response!.data!.round_purpose
            self.totalTime =
                (response?.data!.round_time as! Int)*3600
        }
        
    }
    
    func fetchProjectName() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: self.projectIndex) { (response) in
            self.projectNameLabel.text = response?.data.project_name
        }
    }
    
    // MARK: - Create Timer
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timeLimitLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        
        return String(format: "총 %02d:%02d 남음", minutes, seconds)
    }
    
}

extension AllRoundViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 10
        if count == 0 {
            cardAdditionImg.isHidden = false
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
        cell.memo.text = "샬라 샬라 샬라 샬라 샬라라라랄라라라랄라라라라라라라라라랄"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.392
        return CGSize(width: width, height: collectionView.frame.height)
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
