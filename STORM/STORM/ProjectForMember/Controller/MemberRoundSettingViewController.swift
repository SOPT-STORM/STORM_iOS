//
//  RoundSettingForMemberViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Lottie
import Kingfisher

extension NSNotification.Name {
    static let buttonClickInPopup = NSNotification.Name(rawValue: "buttonClickpopup")
}

class MemberRoundSettingViewController: UIViewController {

    // MARK:- IBOutlet
    
    @IBOutlet weak var loadingView: AnimationView!
    @IBOutlet weak var projectWaitingTableView: UITableView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var roundDoneLabel: UILabel! // 숨겨야할 것
    @IBOutlet weak var roundReadyLabel: UILabel! // 타입캐스팅
    @IBOutlet weak var roundGoalLabel: UILabel! // 타입캐스팅, 변경
    @IBOutlet weak var roundTimeLabel: UILabel! // 타입캐스팅, 변경
    @IBOutlet weak var roundReadyView: UIView! // 숨겨야할 것
    
    @IBOutlet weak var roundInfoView: UIView!
    @IBOutlet weak var ruleButton: UIButton!
    
    
    private var childVC: ReminderPopViewController?
    
    var projectCode = ""
    var projectIndex = 1
    var roundIndex = 1
    var dataList:[Member] = []
    
    private var shadowLayer: CAShapeLayer!
    
    // TODO : 몇번째 라운드인지 타임캐스팅 해서 바꿔야 함
    // 라운드 인트 가져오는 것 우선 했음
    //
    // 룰 확인 버튼 radius + corner
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removePopupView), name: .buttonClickInPopup, object: nil)
    }
    
    @objc func removePopupView() {
        childVC?.willMove(toParent: nil)
        childVC?.removeFromParent()
        //
    }
    
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "allRoundViewController") as! AllRoundViewController
//
//        let naviController = UINavigationController(rootViewController: vc)
//        self.present(naviController, animated: true, completion: nil)
        
        // MARK: TABLE VIEW

//         projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//         projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
//        projectWaitingTableView.delegate = self
//        projectWaitingTableView.dataSource = self
//         projectWaitingTableView.setRadius(radius: 15)
//        projectWaitingTableView.dropShadow(color: .darkGray, opacity: 0.2, offSet: CGSize(width: 0, height: 3), radius: 2.5)
//        
//        projectWaitingTableView.clipsToBounds = true
//        
//        
//        // MARK: LOTTIE
//        
//        let animation = Animation.named("loading3")
//        loadingView.animation = animation
//        loadingView.contentMode = .scaleAspectFit
//        loadingView.play()
//        loadingView.isHidden = false
//        
//        // MARK: 팝업
//        
//        addObserver()
//        
//        // MARK: 프로젝트 이름 통신
//        
//        fetchProjectInfo()
//        fetchRoundInfo()
//        
//        // MARK: RADIUS, SHADOW
//
//        ruleButton.cornerRadius = 8.0
//        ruleButton.clipsToBounds = true
////        
//        SocketIOManager.shared.socket.emit("joinRoom", projectCode)
//        
//        SocketIOManager.shared.sendData(roomCode: projectCode)
//        
////        SocketIOManager.shared.socket.on("roundComplete"){ (dataArray, SocketAckEmitter) in
////            print("소켓 실행")
////
////            NetworkManager.shared.fetchMemberList(roundIdx: 1) { (result) in
////                    print("get통신")
////                    print(result)
////
////                    guard let data = result?.data else {return}
////
////                    self.dataList = data
////                    self.projectWaitingTableView.reloadData()
////                }
////        }
//
//        
//        SocketIOManager.shared.socket.on("roundStartMember"){ (dataArray, SocketAckEmitter) in
//                    print("소켓 실행")
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "allRoundViewController") as! AllRoundViewController
//            
//            let navController = UINavigationController(rootViewController: vc)
//            self.present(navController, animated: true, completion: nil)
//                }
        }
    
    // MARK:- IBAction
    
    // 룰리마인더 버튼
    @IBAction func ruleButtonDidTap(_ sender: UIButton) {
        let popupStoryboard: UIStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        /*
        let ruleReminderPopUpVC = popupStoryboard.instantiateViewController(withIdentifier: "reminderPopUp") as! ReminderPopViewController // 이거 안되면 다시 as! UIViewController로 바꾸기
        self.navigationController?.addChild(ruleReminderPopUpVC)
        ruleReminderPopUpVC.view.frame = UIApplication.shared.keyWindow!.frame
        self.navigationController?.view.addSubview(ruleReminderPopUpVC.view)
        ruleReminderPopUpVC.didMove(toParent: self.navigationController)
        */
        
        let ruleReminderPopUpVC = popupStoryboard.instantiateViewController(withIdentifier: "reminderPopUp") as! ReminderPopViewController // 이거 안되면 다시 as! UIViewController로 바꾸기
        childVC = ruleReminderPopUpVC
        
        self.navigationController?.addChild(ruleReminderPopUpVC)
        ruleReminderPopUpVC.view.frame = self.view.frame
        self.view.addSubview(ruleReminderPopUpVC.view)
        ruleReminderPopUpVC.didMove(toParent: self)
    }

       // 완료되는 시점의 코드 넣기 -> loadingView.stop()
        // Do any additional setup after loading the view.
    }
    

// MARK: - extension

extension MemberRoundSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectWaitingTableViewCell.identifier, for: indexPath) as! ProjectWaitingTableViewCell
        
        cell.nameLabel.text = dataList[indexPath.row].user_name
        
        let imgUrl = dataList[indexPath.row].user_img
        cell.profileImage.kf.setImage(with:URL(string: imgUrl))
        return cell
    }
    
}

extension MemberRoundSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return projectWaitingTableView.frame.height/3
    }
    
    // MARK:- func
    
    
    func fetchProjectInfo() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: self.projectIndex) { (response) in
            self.projectName.text = response?.data.project_name
        }
    }
    
    func fetchRoundInfo() {
        NetworkManager.shared.fetchRoundInfo(projectIdx: self.projectIndex) { (response) in
            self.roundGoalLabel.text = response?.data?.round_purpose
            self.roundTimeLabel.text =
            "총 \(String(describing: response?.data!.round_time))분 예정"
        }
        
    }
 
}
