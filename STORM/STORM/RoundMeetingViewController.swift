//
//  CollecViewController5.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundMeetingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var roundNumbLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    lazy var cards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.setNaviTitle()
        setupLayout()
        setupInfo()
        fetchCardList()
        
        if ProjectSetting.shared.mode == .member{
            finishBtn.isHidden = true
            SocketIOManager.shared.socket.on("memberFinishProject") { (dataArray, SocketAckEmitter) in
                print("소켓 실행")
                print("데이터 \(dataArray)")
                print("소켓 \(SocketAckEmitter)")
                
                // 프로젝트 최종 정리 뷰로 이동
            }
        }
    }
    
    @IBAction func didPressFinishBtn(_ sender: UIButton) {
        guard let selectNextPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "selectNextPopVC") as? SelectNextPopViewController else {return}
        
        selectNextPopVC.modalPresentationStyle = .overCurrentContext
        self.present(selectNextPopVC, animated: false, completion: nil)
    }
    
    func setupLayout() {
        finishBtn.layer.shadowColor = UIColor.black.cgColor
        finishBtn.shadowOffset = CGSize(width: 0, height: -1.0)
        
        finishBtn.layer.shadowOpacity = 0.16
        finishBtn.layer.shadowRadius = 2.5
    }
    
    func setupInfo() {
        let projectInfo = ProjectSetting.shared
        
        projectNameLabel.text = projectInfo.projectName
        roundGoalLabel.text = projectInfo.roundPurpose
        
        guard let roundNumb = projectInfo.roundNumb else {return}
        roundNumbLabel.text = "ROUND\(roundNumb)"
    }
    
    func fetchCardList() {
        let projectInfo = ProjectSetting.shared
        
        guard let projectIndex = projectInfo.projectIdx, let roundIndex = projectInfo.roundIdx else {return}
        
        NetworkManager.shared.fetchCardList(projectIdx: projectIndex , roundIdx: roundIndex) { (response) in
             
            guard let cardList = response?.data?.card_list else {return}
            self.cards = cardList
            self.collectionView.reloadData()
        }
    }
}

extension RoundMeetingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = cards[indexPath.row]
        
        if card.card_img != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
            
            guard let url = card.card_img,let imageURL = URL(string: url) else {return UICollectionViewCell()}
            cell.drawingImgView.kf.setImage(with: imageURL)
            
            cell.index = card.card_idx
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
            cell.memo.text = card.card_txt!
            cell.index = card.card_idx
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.392
        return CGSize(width: width, height: width * 1.075)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let allRoundCarouselVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "allRoundCarouselVC") as? AllRoundCarouselViewController else {return}
        
        allRoundCarouselVC.cards = cards
        allRoundCarouselVC.cellIndexPath = indexPath
        
        self.navigationController?.pushViewController(allRoundCarouselVC, animated: true)
    }
}


