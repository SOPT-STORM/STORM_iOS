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
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var projectName: String?
    var roundGoalText = String()
    var timeLimitText = String()
    
    var members: [Member] = []
    lazy var isEnter: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateParticipantsList), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if ProjectSetting.shared.mode == .member {
            projectStartButton.isHidden = true
            
            SocketIOManager.shared.socket.on("roundStartMember") { (dataArray, SocketAckEmitter) in
                
                if self.presentedViewController == nil {
                    self.presentRoundStartPopup()
                } else {
                    self.presentedViewController?.dismiss(animated: true, completion: {
                        self.presentRoundStartPopup()
                    })
                }
            }
        }
        
        SocketIOManager.shared.socket.on("roundComplete") { [weak self](dataArray, SocketAckEmitter) in
            self?.fetchMemberList()
        }
        
        fetchRoundInfo()
        fetchMemberList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if ProjectSetting.shared.mode == .member {
            SocketIOManager.shared.socket.off("roundStartMember")
        }
        
        SocketIOManager.shared.socket.off("roundComplete")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateParticipantsList() {
        fetchMemberList()
    }
    
    @IBAction func ruleReminderButtonDidPress(_ sender: Any) {
        let reminderPopupViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "reminderPopUpVC") as! ReminderPopViewController
        
        reminderPopupViewController.modalPresentationStyle = .overCurrentContext
        self.present(reminderPopupViewController, animated: false, completion: nil)
    }
    
    @IBAction func didPressRoundStart(_ sender: UIButton) {
        SocketIOManager.shared.socket.emit("roundStartHost", ProjectSetting.shared.projectCode!)
        
        NetworkManager.shared.changeProjectStatus { (response) in
            
        }
        
        presentRoundStartPopup()
    }
    
    @objc func didPressExit() {
        
        guard let exitPopUpVC = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "EndProjectPopViewController") as? EndProjectPopViewController else {return}
        
        exitPopUpVC.presentingVC = "roundStart"
        exitPopUpVC.modalPresentationStyle = .overCurrentContext
        self.present(exitPopUpVC, animated: false, completion: nil)
    
    }
    
    func initialSetup() {
        fetchProjectInfo()

        self.setNaviTitle()
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit" ), style: .plain, target: self, action: #selector(didPressExit))
        
        shadowView.addRoundShadow(contentView: contentView, cornerRadius: 15)
    }
    
    func fetchProjectInfo() {
        guard let projectIndex = ProjectSetting.shared.projectIdx else {return}
        NetworkManager.shared.fetchProjectInfo(projectIdx: projectIndex) { [weak self] (response) in
            guard let projectName = response?.data?.project_name else {return}
            ProjectSetting.shared.projectName = projectName
            self?.projectNameLabel.text = projectName
        }
    }
    
    func fetchRoundInfo() {
        guard let roundIndex = ProjectSetting.shared.roundIdx else {return}
        NetworkManager.shared.fetchRoundInfo(roundIdx: roundIndex) {[weak self] (response) in
            
            guard let roundNumb = response?.data?.round_number, let roundTime = response?.data?.round_time, let roundPurpose = response?.data?.round_purpose, let roundIndex = ProjectSetting.shared.roundIdx  else {return}
            
            ProjectSetting.shared.roundTime = Double(roundTime)
            ProjectSetting.shared.roundPurpose = roundPurpose
            ProjectSetting.shared.roundIdx = roundIndex
            ProjectSetting.shared.roundNumb = roundNumb
            
            if ProjectSetting.shared.mode == .host {
                self?.roundStateLabel.text = "ROUND \(roundNumb) 설정 완료"
            }else {
                self?.roundStateLabel.text = "ROUND \(roundNumb) 대기 중"
                self?.roundStartInfoLabel.isHidden = true
            }
            
            self?.roundInfoLabel.text  = "\(roundPurpose) \n 총 \(roundTime)분 예정"
        }
    }
    
    func fetchMemberList() {
        guard let roundIndex = ProjectSetting.shared.roundIdx, let projectIndex = ProjectSetting.shared.projectIdx else {return}
        
        NetworkManager.shared.fetchMemberList(roundIdx: roundIndex, projectIdx: projectIndex) {[weak self] (result) in
            self?.members = result!.data!
            
            if NetworkManager.shared.user_idx == result!.data![0].user_idx && result!.data![0].user_host_flag == 1 {
                
                self?.changeModeMemberToHost()
            }
            
            self?.participantsTableView.reloadData()
        }
    }
    
    func changeModeMemberToHost() {
        ProjectSetting.shared.mode = .host
        projectStartButton.isHidden = false
        roundStartInfoLabel.isHidden = false
        guard let roundNumb = ProjectSetting.shared.roundNumb else {return}
        self.roundStateLabel.text = "ROUND \(roundNumb) 설정 완료"
        SocketIOManager.shared.socket.off("roundStartMember")
    }
    
    func setupTableView() {
        participantsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
        participantsTableView.setRadius(radius: 15)
        participantsTableView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        participantsTableView.clipsToBounds = true
        participantsTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = ProjectSetting.shared.projectCode!
    }
    
    func presentRoundStartPopup() {
        let roundStartPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "roundStartPopVC") as! RoundStartPopViewController
        
        roundStartPopVC.delegate = self
        roundStartPopVC.modalPresentationStyle = .overCurrentContext
        
        self.present(roundStartPopVC, animated: false, completion: nil)
    }
    
    
    // MARK: - Display Toast Popup
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        self.showToast(message: "참여 코드가 복사되었습니다", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
        getCopiedText()
    }
}

// MARK: - extension

extension RoundStartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell", for: indexPath) as! ParticipantCell
        
        let member = members[indexPath.row]
        
        if member.user_host_flag == 1 {
            cell.userNameLabel!.text = member.user_name + " (HOST)"
        } else {
            cell.userNameLabel!.text = member.user_name
        }
        
        guard let imageURL = URL(string: member.user_img) else {return UITableViewCell()}
        
        cell.profileImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
}

extension RoundStartViewController: PresentDelegate {
    func presentVC() {
        
        if let allRoundVC = UIStoryboard(name: "ProjectRound", bundle: nil).instantiateViewController(withIdentifier: "allRoundVC") as? AllRoundViewController {
            
            let naviController = UINavigationController(rootViewController: allRoundVC)
            naviController.modalPresentationStyle = .fullScreen
            self.present(naviController, animated: false, completion: nil)
        }
    }
}
