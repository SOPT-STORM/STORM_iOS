//
//  HostProjectWaitingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostProjectWaitingViewController: UIViewController {
    
    static let identifier = "HostProjectWaitingViewController"
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStartButton: UIButton!
    @IBOutlet weak var projectWaitingTableView: UITableView!
    @IBOutlet weak var ruleReminderImage: UIImageView!
    @IBOutlet weak var ruleReminderView: UIView!
    @IBOutlet weak var pasteCodeImage: UIImageView!
    @IBOutlet var codePastedGesture: UITapGestureRecognizer!
    @IBOutlet weak var hostMessageLabel: UILabel!
    
    var projectName = String()
    var hostMessage = String()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
        projectWaitingTableView.delegate = self
        projectWaitingTableView.dataSource = self
        projectWaitingTableView.setRadius(radius: 15)
        projectWaitingTableView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        projectWaitingTableView.clipsToBounds = true
        projectStartButton.addShadow(width: 0, height: 3, 0.16, 2.5)
        
        // projectWaitingTableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 14)
        // TODO: 스크롤바 인셋 설정 버전별로 다르게 해야하는데 어떻게 하지.?
        // TODO: 또 그림자가 적용 안 됨..ㅠㅠㅠ
        
        
        // MARK: - Add Gesture Recognizer
        
        let tapReminderView = UITapGestureRecognizer(target: self, action: #selector(handleReminderView(sender:)))
        ruleReminderView.addGestureRecognizer(tapReminderView)
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
        
        
        
    }
    
    var projectInfo: Project? {
        didSet {
            projectNameLabel.text = projectInfo?.project_name
            hostMessageLabel.text = projectInfo?.project_comment
        }
    }
    
    func getProjectInfo() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: 0) { (response) in
            self.projectInfo = response?.data
        }
    }
    
    // MARK: - Connect to Brainstorming Rule Reminder
    
    @objc func handleReminderView(sender: UITapGestureRecognizer) {
        print("tap")
        let reminderPopupViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: ReminderPopViewController.identifier) as! ReminderPopViewController
        
        // MARK: - Display Brainstorming Rule Reminder Popup View Controller
        
//        self.addChild(reminderPopupViewController)
//        reminderPopupViewController.view.frame = self.view.frame
//        reminderPopupViewController.didMove(toParent: self)
//        self.view.addSubview(reminderPopupViewController.view)
//        reminderPopupViewController.pressButton = { self.ruleReminderImage.image = (UIImage(named: "mProjectwaitingBrainstormingOkSelected"))
//        }
        
        
        
    }
    
    // MARK: - Display Toast Popup
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        print("tap111")
        self.showToast(message: "참여코드가 복사되었습니다.", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC : HostProjectSettingViewController = segue.destination as! HostProjectSettingViewController
        destinationVC.delegate = self
    }*/
    
    // MARK: - IBAction
    
    @IBAction func projectStartButtonDidPress(_ sender: UIButton) {
        
        let hostRoundSettingVC = UIStoryboard.init(name: "ProjectForHost", bundle: nil).instantiateViewController(withIdentifier: HostRoundSettingViewController.identifier)
        hostRoundSettingVC.modalTransitionStyle = .coverVertical
        self.present(hostRoundSettingVC, animated: false, completion: nil)
        
    }
}



// MARK: - extension

extension HostProjectWaitingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectWaitingTableViewCell.identifier, for: indexPath) as! ProjectWaitingTableViewCell
        return cell
    }
    
}

extension HostProjectWaitingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return projectWaitingTableView.bounds.height/3
    }
}
