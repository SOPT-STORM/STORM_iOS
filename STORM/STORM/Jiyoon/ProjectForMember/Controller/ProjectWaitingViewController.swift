//
//  ProjectWaitingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectWaitingViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var projectCodePasteButton: UIButton!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStartButton: UIButton!
    @IBOutlet weak var ruleReminderButton: UIButton!
    @IBOutlet weak var projectWaitingTableView: UITableView!
    @IBOutlet weak var ruleReminderImage: UIImageView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        projectCodePasteButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3))
        projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
        projectWaitingTableView.delegate = self
        projectWaitingTableView.dataSource = self
        projectWaitingTableView.setRadius(radius: 15)
        projectWaitingTableView.clipsToBounds = true
        projectWaitingTableView.dropShadow(color: .darkGray, opacity: 0.2, offSet: CGSize(width: 0, height: 3), radius: 5, scale: true)
        ruleReminderButton.setRadius(radius: 15)
        ruleReminderButton.dropShadow(color: .darkGray, opacity: 0.2, offSet: CGSize(width: 0, height: 3), radius: 3, scale: true)
        // TODO: 그림자 방향이 이상해ㅠㅠ 방향 재설정

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    // MARK: - IBAction
    
    @IBAction func projectCodePasteButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func ruleReminderButtonDidPress(_ sender: UIButton) {
        let reminderPopupViewController = UIStoryboard(name: "ProjectForMember", bundle: nil).instantiateViewController(withIdentifier: ReminderPopupViewController.identifier) as! ReminderPopupViewController
        self.addChild(reminderPopupViewController)
        reminderPopupViewController.view.frame = self.view.frame
        reminderPopupViewController.didMove(toParent: self)
        self.view.addSubview(reminderPopupViewController.view)
        reminderPopupViewController.pressButton = { self.ruleReminderImage.image = (UIImage(named: "mProjectwaitingBrainstormingOkSelected"))
            
        }
       // reminderPopupViewController.modalPresentationStyle = .overCurrentContext
        
        // TODO: 투명도 설정했는데 뷰가 안 겹쳐진다!
    }
    @IBAction func projectStartButtonDidPress(_ sender: UIButton) {
    }
    
    

}

extension ProjectWaitingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectWaitingTableViewCell.identifier, for: indexPath) as! ProjectWaitingTableViewCell
        return cell
    }
    
}

extension ProjectWaitingViewController: UITableViewDelegate {

    
    
}
