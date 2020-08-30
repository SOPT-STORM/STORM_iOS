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
    
    @IBOutlet weak var nextRoundNotificationView: UIView!
    
    @IBOutlet weak var botConstOfnextRoundNoti: NSLayoutConstraint!
    
    lazy var cards: [Card] = []
    lazy var isWaitNextRound: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        self.setNaviTitle()
        setupLayout()
        setupInfo()
        
        if ProjectSetting.shared.mode == .member {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit" ), style: .plain, target: self, action: #selector(didPressExit))
        }
        
        ProjectSetting.shared.scrapCards.removeAll()
        
        nextRoundNotificationView.layer.maskedCorners = [.layerMinXMinYCorner, . layerMaxXMinYCorner]
        
        nextRoundNotificationView.cornerRadius = 20
        nextRoundNotificationView.layer.shadowColor = UIColor.black.cgColor
        nextRoundNotificationView.shadowOffset = CGSize(width: 0, height: -1.0)
        nextRoundNotificationView.layer.shadowOpacity = 0.16
        nextRoundNotificationView.layer.shadowRadius = 2.5
        setupMemberSocket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCardList()
    }
    
    @IBAction func didPressFinishBtn(_ sender: UIButton) {

        if ProjectSetting.shared.roundNumb == 9 {
            guard let oneLinePopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "oneLineMessagePopVC") as?         OneLineMessagePopViewController, let roundNumb = ProjectSetting.shared.roundNumb else {return}
            
            oneLinePopVC.message = "ROUND \(roundNumb) 종료"
            oneLinePopVC.presentingVC = "roundMeetingVC"
            oneLinePopVC.modalPresentationStyle = .overCurrentContext
            self.present(oneLinePopVC, animated: false, completion: nil)
        } else {
            guard let selectNextPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "selectNextPopVC") as? SelectNextPopViewController, let roundNumb = ProjectSetting.shared.roundNumb else {return}
            
            selectNextPopVC.roundNumb = roundNumb
            selectNextPopVC.modalPresentationStyle = .overCurrentContext
            self.present(selectNextPopVC, animated: false, completion: nil)
        }
    }
    
    @objc func didPressExit() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "projectFinalViewController") as? ProjectFinalViewController else {return}
        
        let naviController = UINavigationController(rootViewController: vc)
        naviController.modalPresentationStyle = .fullScreen
        
        self.present(naviController, animated: false, completion: nil)
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
        
        let roundTime = Int(ProjectSetting.shared.roundTime)
        timeLabel.text = "총 \(roundTime)분 소요"
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
    
    func setupMemberSocket() {
        if ProjectSetting.shared.mode == .member{
            finishBtn.isHidden = true
            
            SocketIOManager.shared.socket.on("waitNextRound") { (dataArray, SocketAckEmitter) in
                print("소켓 실행")
                print("데이터 \(dataArray)")
                print("소켓 \(SocketAckEmitter)")
                self.isWaitNextRound = true
                
                //  호스트가 다음 라운드를 세팅중이라는 안내문구를 띄우기
                UIView.animate(withDuration: 1) {
                    self.botConstOfnextRoundNoti.constant = 0
                    self.view.layoutIfNeeded()
                }
                
                guard let carouselView = self.navigationController?.visibleViewController as? AllRoundCarouselViewController else {return}
                
                print("여기 실행됨~~~!!")
                carouselView.showUpNextRoundNoti()
            }
            
            SocketIOManager.shared.socket.on("memberNextRound") { (dataArray, SocketAckEmitter) in
                print("소켓 실행")
                print("데이터 \(dataArray)")
                print("소켓 \(SocketAckEmitter)")
                
                    NetworkManager.shared.enterRound { (response) in
                        guard let roundIndex = response.data, let projectCode = ProjectSetting.shared.projectCode else {return}
                        ProjectSetting.shared.roundIdx = roundIndex
  
                        SocketIOManager.shared.socket.emit("enterNextRound", projectCode) {
                            print("enterNextRound 실행")
                            self.socketOff()
                            self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                        }
                    }
                
            }
            
            SocketIOManager.shared.socket.on("memberFinishProject") { (dataArray, SocketAckEmitter) in
                print("소켓 실행")
                print("데이터 \(dataArray)")
                print("소켓 \(SocketAckEmitter)")
                
                // 프로젝트 최종 정리 뷰로 이동
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "projectFinalViewController") as? ProjectFinalViewController else {return}
                
                self.socketOff()
                let naviController = UINavigationController(rootViewController: vc)
                naviController.modalPresentationStyle = .fullScreen
                self.present(naviController, animated: true, completion: nil)
            }
        }
    }
    
    func socketOff() {
        SocketIOManager.shared.socket.off("waitNextRound")
        SocketIOManager.shared.socket.off("memberNextRound")
        SocketIOManager.shared.socket.off("memberFinishProject")
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
            
            cell.cardIndex = card.card_idx
            cell.cellIndex = indexPath.row
            
            if card.scrap_flag == 1 {
                cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.heartBtn.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                cell.isScrapped = true
            } else {
                cell.heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.heartBtn.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                cell.isScrapped = false
            }
            
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
            cell.memo.text = card.card_txt!
            cell.cardIndex = card.card_idx
            cell.cellIndex = indexPath.row
            
            if card.scrap_flag == 1 {
                cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.heartBtn.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                cell.isScrapped = true
            } else {
                cell.heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.heartBtn.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                cell.isScrapped = false
            }
            
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
        
        print("눌리는 셀 \(indexPath.row)")
        
        guard let allRoundCarouselVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "allRoundCarouselVC") as? AllRoundCarouselViewController else {return}
        
        allRoundCarouselVC.cards = cards
        allRoundCarouselVC.cellIndexPath = indexPath
        allRoundCarouselVC.isWaitNextRound = isWaitNextRound
        
        self.navigationController?.pushViewController(allRoundCarouselVC, animated: true)
    }
}


