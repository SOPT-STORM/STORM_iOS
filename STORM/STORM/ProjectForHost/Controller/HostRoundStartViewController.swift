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
    
    static let identifier = "HostRoundStartViewController"
    let projectIndex = UserDefaults.standard.integer(forKey: "projectIndex")
    let roundIndex = 1 //UserDefaults.standard.integer(forKey: "roundIndex")
//    var numberOfRows = 0
    var testString = String()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStartButton: UIButton!
    @IBOutlet weak var projectWaitingTableView: UITableView!
    @IBOutlet weak var pasteCodeImage: UIImageView!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var timeLImitLabel: UILabel!
    @IBOutlet weak var ruleReminderButton: UIButton!
    @IBOutlet weak var roundIndexSetLabel: UILabel!
    
    var roundGoalText = String()
    var timeLimitText = String()
    
    var members: [Member] = []
    
    var socket: SocketIOClient!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let manager = SocketManager(socketURL: URL(string: "http://4cd4fd360e7c.ngrok.io")!, config: [.log(true), .compress])
//
//        self.socket = manager.defaultSocket
//
////        self.socket.connect()
//
//        self.socket.on("roundcomplete") { (dataArray, SocketAckEmitter) in
//                    print("소켓 실행")
//        //            print("데이터 \(dataArray)")
//        //            print("소켓 \(SocketAckEmitter)")
//
//                    NetworkManager.shared.fetchMemberList(roundIdx: 1) { (result) in
//                        print("get통신")
//                        print(result)
//                    }
//                }
//
//        self.socket.connect()
//
//        socket.emit("joinRoom", ["roomCode", "지윤"])
//        socket.emit("roundSetting", "roomCode")
        
//        SocketIOManager.shared.openConnection()
        SocketIOManager.shared.sendData()
        
        SocketIOManager.shared.socket.on("roundComplete") { (dataArray, SocketAckEmitter) in
                print("소켓 실행")
        //            print("데이터 \(dataArray)")
        //            print("소켓 \(SocketAckEmitter)")
                    
                NetworkManager.shared.fetchMemberList(roundIdx: 1) { (result) in
                    print("get통신")
                    print(result!.data!)
                    self.members = result!.data!
                    self.projectWaitingTableView.reloadData()
            }
        }
        
//                socket.on("roundComplete") { (dataArray, SocketAckEmitter) in
//                    print("소켓 실행")
//        //            print("데이터 \(dataArray)")
//        //            print("소켓 \(SocketAckEmitter)")
//
//                    NetworkManager.shared.fetchMemberList(roundIdx: 1) { (result) in
//                        print("get통신")
//                        print(result)
//                    }
//                }
        
        
        projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
        projectWaitingTableView.delegate = self
        projectWaitingTableView.dataSource = self
        projectWaitingTableView.setRadius(radius: 15)
        projectWaitingTableView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        projectWaitingTableView.clipsToBounds = true
        
        
        // TODO: 또 그림자가 적용 안 됨..ㅠㅠㅠ
        


        
        // TODO: TapGestureRecognizer 인식 안됨 문제
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
        
        fetchRoundInfo()
        fetchProjectInfo()
        fetchRoundCountInfo()
    }
    
    

    
    // MARK: - Receive Data
    
    func fetchRoundInfo() {
        NetworkManager.shared.fetchRoundInfo(projectIdx: self.projectIndex) { (response) in
            print(response?.status)
            print(response?.message)
            self.roundIndexSetLabel.text = "ROUND\(String(describing: response!.data!.round_idx)) 설정 완료"
            self.roundGoalLabel.text = response?.data!.round_purpose
            self.timeLImitLabel.text = "총 \(String(describing: response!.data!.round_time))분 예정"
        }
        
        }
    
    func fetchRoundCountInfo() {
        NetworkManager.shared.fetchRoundCountInfo(projectIdx: self.projectIndex) { (response) in
            self.roundIndexSetLabel.text = "ROUND\(String(describing: response!.data!)) 설정 완료"
        }
    }

    var projectInfo: Project?? {
        didSet {
            projectNameLabel.text = projectInfo??.project_name
            
        }
    }
    
    func fetchProjectInfo() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: self.projectIndex) { (response) in
            self.projectInfo = response?.data
        }
    }
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = (UserDefaults.standard.value(forKey: "projectCode") as! String)
        print("copied")
    }
    
    
    // MARK: - Display Toast Popup
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        print("tap111")
        self.showToast(message: "참여코드가 복사되었습니다.", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
        getCopiedText()
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func projectStartButtonDidPress(_ sender: UIButton) {
        let hostRoundStartPopVC = UIStoryboard.init(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: RoundStartPopViewController.identifier)
        self.addChild(hostRoundStartPopVC)
        hostRoundStartPopVC.view.frame = self.view.frame
        hostRoundStartPopVC.didMove(toParent: self)
        self.view.addSubview(hostRoundStartPopVC.view)
    }
    
    @IBAction func ruleReminderButtonDidPress(_ sender: Any) {
    let reminderPopupViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: ReminderPopViewController.identifier) as! ReminderPopViewController
           
           // MARK: - Display Brainstorming Rule Reminder Popup View Controller
           
           self.addChild(reminderPopupViewController)
           reminderPopupViewController.view.frame = self.view.frame
           reminderPopupViewController.didMove(toParent: self)
           self.view.addSubview(reminderPopupViewController.view)
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
