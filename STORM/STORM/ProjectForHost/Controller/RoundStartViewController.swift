//
//  HostRoundStartViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import SocketIO

class RoundStartViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStartButton: UIButton!
    @IBOutlet weak var participantsTableView: UITableView!
    @IBOutlet weak var pasteCodeImage: UIImageView!

    @IBOutlet weak var ruleReminderButton: UIButton!
    
    @IBOutlet weak var roundStateLabel: UILabel!

    @IBOutlet weak var roundInfoLabel: UILabel!
    @IBOutlet weak var roundStartInfoLabel: UILabel!
    
    var projectName: String?
    var roundGoalText = String()
    var timeLimitText = String()
    
    var members: [Member] = []

    var isFetchedRoundInfo: Bool = false
    var isEnter: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if ProjectSetting.shared.mode == .member {
            SocketIOManager.shared.socket.on("roundStartMember") { (dataArray, SocketAckEmitter) in
                
                self.presentRoundStartPopup()
            }
        }
        
        SocketIOManager.shared.socket.on("roundComplete") { (dataArray, SocketAckEmitter) in
            print("socket roundcomplete")
            
            self.fetchMemberList()
        }
        
        initialSetup()
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
    }
    
    @IBAction func ruleReminderButtonDidPress(_ sender: Any) {
        let reminderPopupViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "reminderPopUpVC") as! ReminderPopViewController

        reminderPopupViewController.modalPresentationStyle = .overCurrentContext
        self.present(reminderPopupViewController, animated: false, completion: nil)
    }
    
    @IBAction func didPressRoundStart(_ sender: UIButton) {
        presentRoundStartPopup()
    }
    
    @objc func didPressExit() {
        NetworkManager.shared.exitRound { (response) in
            if response?.status == 200 {
                guard let projectCode = ProjectSetting.shared.projectCode else {return}
                SocketIOManager.shared.socket.emit("leaveRoom", projectCode)
            }
        }

        let rootVC = self.view.window?.rootViewController
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            guard let navi = rootVC as? UINavigationController else {return}
            navi.popToRootViewController(animated: false)
        })
    }
    
    func initialSetup() {
        fetchProjectInfo()
        fetchRoundInfo()
        fetchMemberList()
        self.setNaviTitle()
        setupTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit" ), style: .plain, target: self, action: #selector(didPressExit))
    }
    
    func fetchProjectInfo() {
        guard let projectIndex = ProjectSetting.shared.projectIdx else {return}
        NetworkManager.shared.fetchProjectInfo(projectIdx: projectIndex) { (response) in
            guard let projectName = response?.data?.project_name else {return}
            ProjectSetting.shared.projectName = projectName
            self.projectNameLabel.text = projectName
        }
    }
    
    func fetchRoundInfo() {
        guard let roundIndex = ProjectSetting.shared.roundIdx else {return}
        NetworkManager.shared.fetchRoundInfo(roundIdx: roundIndex) { (response) in

            guard let roundNumb = response?.data?.round_number, let roundTime = response?.data?.round_time, let roundPurpose = response?.data?.round_purpose, let roundIndex = ProjectSetting.shared.roundIdx  else {return}

            ProjectSetting.shared.roundTime = Double(roundTime)
            ProjectSetting.shared.roundPurpose = roundPurpose
            ProjectSetting.shared.roundIdx = roundIndex
            ProjectSetting.shared.roundNumb = roundNumb
            
            if ProjectSetting.shared.mode == .host {
                self.roundStateLabel.text = "ROUND\(roundNumb) 설정 완료"
            }else {
                self.roundStateLabel.text = "ROUND\(roundNumb) 준비 완료"
                self.roundStartInfoLabel.isHidden = true
            }
            
            self.roundInfoLabel.text  = "\(roundPurpose) \n 총 \(roundTime)분 예정"
        }
    }
    
    func fetchMemberList() {
        guard let roundIndex = ProjectSetting.shared.roundIdx, let projectIndex = ProjectSetting.shared.projectIdx else {return}
        
        NetworkManager.shared.fetchMemberList(roundIdx: roundIndex, projectIdx: projectIndex) { (result) in
            self.members = result!.data!
            self.participantsTableView.reloadData()
        }
    }
    
    func setupTableView() {
        participantsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        participantsTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
        participantsTableView.setRadius(radius: 15)
        participantsTableView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        participantsTableView.clipsToBounds = true
    }
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = ProjectSetting.shared.projectCode!
        print("copied")
    }
    
    func presentRoundStartPopup() {
        let roundStartPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "roundStartPopVC") as! RoundStartPopViewController
        
        roundStartPopVC.delegate = self
        roundStartPopVC.modalPresentationStyle = .overCurrentContext
        
        SocketIOManager.shared.socket.emit("roundStartHost", ProjectSetting.shared.projectCode!)
        
        self.present(roundStartPopVC, animated: false, completion: nil)
    }
    
    
    // MARK: - Display Toast Popup
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        self.showToast(message: "참여코드가 복사되었습니다.", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
        getCopiedText()
    }
}

// MARK: - extension

extension RoundStartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectWaitingTableViewCell", for: indexPath) as! ProjectWaitingTableViewCell
        
        let member = members[indexPath.row]

        if member.user_host_flag == 1 {
            cell.nameLabel!.text = member.user_name + " (HOST)"
        } else {
            cell.nameLabel!.text = member.user_name
        }
        
        return cell
    }
}

extension RoundStartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return participantsTableView.frame.height/3
    }
}

extension RoundStartViewController: PresentVC {
    func presentVC() {
  
        if let allRoundVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "allRoundVC") as? AllRoundViewController {
            
            let naviController = UINavigationController(rootViewController: allRoundVC)
            naviController.modalPresentationStyle = .fullScreen
            self.present(naviController, animated: false, completion: nil)
        }
    }
}
