//
//  HostRoundStartViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostRoundStartViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStartButton: UIButton!
    @IBOutlet weak var projectWaitingTableView: UITableView!
    @IBOutlet weak var pasteCodeImage: UIImageView!
    @IBOutlet weak var toastPopupImage: UIImageView!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var timeLImitLabel: UILabel!
    
    var roundGoalText = String()
    var timeLimitText = String()
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
        projectWaitingTableView.delegate = self
        projectWaitingTableView.dataSource = self
        projectWaitingTableView.setRadius(radius: 15)
        projectWaitingTableView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        projectWaitingTableView.clipsToBounds = true
        
        // projectWaitingTableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 14)
        // TODO: 스크롤바 인셋 설정 버전별로 다르게 해야하는데 어떻게 하지.?
        // TODO: 또 그림자가 적용 안 됨..ㅠㅠㅠ
        
//        projectStartButton.addShadow(width: 0, height: 3, 0.16, 2.5)
        toastPopupImage.isHidden = true
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage(sender:)))
        
        
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
        roundGoalLabel.text = roundGoalText
        timeLImitLabel.text = "총 \(timeLimitText) 예정"
        self.present(UIViewController(), animated: false, completion: nil)

        
    }
    
    
    // TODO: toast popup 구현 붙이기
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        print("tap")
        /*
         UIView.animate(withDuration: 0.5, animations: {
         self.toastPopupImage.isHidden = false
         self.toastPopupImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
         });
         
         UIView.animate(withDuration: 0.5, animations: {
         self.toastPopupImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
         self.toastPopupImage.isHidden = true;
         });
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func projectCodePasteButtonDidPress(_ sender: UIButton) {
    }
    /*
     @IBAction func ruleReminderButtonDidPress(_ sender: UIButton) {
     let reminderPopupViewController = UIStoryboard(name: "ProjectForMember", bundle: nil).instantiateViewController(withIdentifier: ReminderPopupViewController.identifier) as! ReminderPopupViewController
     
     // Pop up view 구현
     
     self.addChild(reminderPopupViewController)
     reminderPopupViewController.view.frame = self.view.frame
     reminderPopupViewController.didMove(toParent: self)
     self.view.addSubview(reminderPopupViewController.view)
     reminderPopupViewController.pressButton = { self.ruleReminderImage.image = (UIImage(named: "mProjectwaitingBrainstormingOkSelected"))
     }
     } */
    
    
    @IBAction func projectStartButtonDidPress(_ sender: UIButton) {
    }
    
    
}




// MARK: - extension

extension HostRoundStartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectWaitingTableViewCell.identifier, for: indexPath) as! ProjectWaitingTableViewCell
        return cell
    }
    
}

extension HostRoundStartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return projectWaitingTableView.frame.height/3
    }
}
