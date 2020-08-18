//
//  HostRoundStartViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import SocketIO

class HostRoundStartViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStartButton: UIButton!
    @IBOutlet weak var projectWaitingTableView: UITableView!
    @IBOutlet weak var pasteCodeImage: UIImageView!

    @IBOutlet weak var ruleReminderButton: UIButton!
    
    @IBOutlet weak var roundStateLabel: UILabel!

    @IBOutlet weak var roundInfoLabel: UILabel!
    @IBOutlet weak var roundStartInfoLabel: UILabel!
    
    var projectName: String?
    var roundGoalText = String()
    var timeLimitText = String()
    
    var members: [Member] = []
//    var socket: SocketIOClient!
    var isFetchedRoundInfo: Bool = false
    var isEnter: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProjectInfo()
        setInitialRoundInfo()
        
        self.setNaviTitle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit" ), style: .plain, target: self, action: #selector(didPressExit))
        
        SocketIOManager.shared.socket.on("roundComplete") { (dataArray, SocketAckEmitter) in
            print("소켓 실행")
            print("데이터 \(dataArray)")
            print("소켓 \(SocketAckEmitter)")
            
            guard let roundIndex = ProjectSetting.shared.roundIdx else {
                print("라운드 인덱스 없음")
                self.fetchRoundInfo()
                return}
            
             print("라운드 인덱스 있음")
            
            NetworkManager.shared.fetchMemberList(roundIdx: roundIndex) { (result) in
                print("get통신")
                print("프로젝트 라운드 인덱스 \(roundIndex)")
                print(result!.data!)
                self.members = result!.data!
                self.projectWaitingTableView.reloadData()
            }
        }
    
        projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
        projectWaitingTableView.delegate = self
        projectWaitingTableView.dataSource = self
        projectWaitingTableView.setRadius(radius: 15)
        projectWaitingTableView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        projectWaitingTableView.clipsToBounds = true
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
    }
    
    @objc func didPressExit() {

        let rootVC = self.view.window?.rootViewController
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            guard let navi = rootVC as? UINavigationController else {return}
            navi.popToRootViewController(animated: false)
        })
    }
    
    
    func setInitialRoundInfo() {
        if ProjectSetting.shared.mode == .host {
//            roundReadyLabel.removeFromSuperview()
//            loadingView.removeFromSuperview()
        }else{
            roundStartInfoLabel.isHidden = true
            projectStartButton.removeFromSuperview()
            roundStateLabel.isHidden = true
//            let animation = Animation.named("loading3")
//            loadingView.animation = animation
//            loadingView.contentMode = .scaleAspectFit
//            loadingView.play()
            
            roundInfoLabel.text = "호스트가 설정을 완료하면,\n ROUND 정보를 확인할 수 있습니다."
            
            SocketIOManager.shared.socket.on("roundStartMember") { (dataArray, SocketAckEmitter) in
                print("소켓 실행 & 멤버 라운드 시작")
                print("데이터 \(dataArray)")
                print("소켓 \(SocketAckEmitter)")
                
                let hostRoundStartPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "roundStartPopVC") as! RoundStartPopViewController
                
                hostRoundStartPopVC.delegate = self
                hostRoundStartPopVC.modalPresentationStyle = .overCurrentContext
                
                self.present(hostRoundStartPopVC, animated: false, completion: nil)
                }
            }
        }
    
    func fetchRoundInfo() {
        
        guard let projectIndex = ProjectSetting.shared.projectIdx else {return}
        
        print("프로젝트 인덱스\(projectIndex)")
        
        NetworkManager.shared.fetchRoundInfo(projectIdx: projectIndex) { (response) in
            guard let roundNumb = response?.data?.round_number, let roundTime = response?.data?.round_time, let roundPurpose = response?.data?.round_purpose, let roundIndex = response?.data?.round_idx  else {return}
            
            if self.isFetchedRoundInfo == false {
            ProjectSetting.shared.roundTime = Double(roundTime)
            ProjectSetting.shared.roundPurpose = roundPurpose
            ProjectSetting.shared.roundIdx = roundIndex
            ProjectSetting.shared.roundNumb = roundNumb

            if ProjectSetting.shared.mode == .host {
                self.roundStateLabel.text = "ROUND\(roundNumb) 설정 완료"
            }else {
                self.roundStateLabel.text = "ROUND\(roundNumb) 준비 완료"
//                self.roundReadyLabel.isHidden = true
                self.roundStateLabel.isHidden = false
//                self.loadingView.removeFromSuperview()
            }

            self.roundInfoLabel.text  = "\(roundPurpose) \n 총 \(roundTime)분 예정"
                self.isFetchedRoundInfo = true
            }
            
            if self.isEnter == false {
                 NetworkManager.shared.enterRound(roundIdx: roundIndex) { (response) in
                     print(response)
                    NetworkManager.shared.fetchMemberList(roundIdx: roundIndex) { (result) in
                        print("get통신")
                        print("프로젝트 라운드 인덱스 \(roundIndex)")
                        print(result!.data!)
                        self.members = result!.data!
                        self.projectWaitingTableView.reloadData()
                    }
                 }
                 self.isEnter = true
            } else {
                NetworkManager.shared.fetchMemberList(roundIdx: roundIndex) { (result) in
                    print("get통신")
                    print("프로젝트 라운드 인덱스 \(roundIndex)")
                    print(result!.data!)
                    self.members = result!.data!
                    self.projectWaitingTableView.reloadData()
                }
            }
        
        }
    }
    
    // MARK: - Receive Data
    
//    func fetchRoundInfo() {
//        NetworkManager.shared.fetchRoundInfo(projectIdx: ProjectSetting.shared.projectIdx!) { (response) in
//            self.roundStateLabel.text = "ROUND\(String(describing: response!.data!.round_idx)) 설정 완료"
//            self.roundInfoLabel.text = response!.data!.round_purpose
////            self.timeLImitLabel.text = "총 \(String(describing: response!.data!.round_time))분 예정"
////            self.roundStateLabel.text = "ROUND\(String(describing: response!.data!.round_number)) 설정 완료"
//        }
//
//    }
    
    func fetchProjectInfo() {
        guard let projectIndex = ProjectSetting.shared.projectIdx else {return}
        NetworkManager.shared.fetchProjectInfo(projectIdx: projectIndex) { (response) in
            guard let projectName = response?.data.project_name else {return}
            ProjectSetting.shared.projectName = projectName
            self.projectNameLabel.text = projectName
        }
    }
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = ProjectSetting.shared.projectCode!
        print("copied")
    }
    
    
    // MARK: - Display Toast Popup
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        self.showToast(message: "참여코드가 복사되었습니다.", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
        getCopiedText()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func projectStartButtonDidPress(_ sender: UIButton) {
        let hostRoundStartPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "roundStartPopVC") as! RoundStartPopViewController
        
        hostRoundStartPopVC.delegate = self
        hostRoundStartPopVC.modalPresentationStyle = .overCurrentContext
        
        SocketIOManager.shared.socket.emit("roundStartHost", ProjectSetting.shared.projectCode!)
        
        self.present(hostRoundStartPopVC, animated: false, completion: nil)
    }
    
    @IBAction func ruleReminderButtonDidPress(_ sender: Any) {
        let reminderPopupViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "reminderPopUpVC") as! ReminderPopViewController

        reminderPopupViewController.modalPresentationStyle = .overCurrentContext
        self.present(reminderPopupViewController, animated: false, completion: nil)
    }
}

// MARK: - extension

extension HostRoundStartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectWaitingTableViewCell", for: indexPath) as! ProjectWaitingTableViewCell
        
        cell.nameLabel!.text = members[indexPath.row].user_name
        
        return cell
    }
}

extension HostRoundStartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return projectWaitingTableView.frame.height/3
    }
}

extension HostRoundStartViewController: PresentVC {
    func presentVC() {
  
        if let allRoundVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "allRoundVC") as? AllRoundViewController {
            
            let naviController = UINavigationController(rootViewController: allRoundVC)
            naviController.modalPresentationStyle = .fullScreen
            self.present(naviController, animated: false, completion: nil)
        }
    }
}
