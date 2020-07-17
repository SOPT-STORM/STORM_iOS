//
//  RoundSettingForMemberViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Lottie

class MemberRoundSettingViewController: UIViewController {

    static let identifier = "MemberRoundSettingViewController"

        @IBOutlet weak var loadingView: AnimationView!
        @IBOutlet weak var roundIndexButton: UIButton!
        @IBOutlet weak var projectWaitingTableView: UITableView!
        @IBOutlet weak var roundGoalLabel: UILabel!
        @IBOutlet weak var timeLimitLabel: UILabel!
        @IBOutlet weak var roundSetFinishedLabel: UILabel!
        
        var projectName = String()
        var roundIndex = String()

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
             projectWaitingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
             projectWaitingTableView.register(UINib(nibName: "ProjectWaitingTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectWaitingTableViewCell.identifier)
            projectWaitingTableView.delegate = self
            projectWaitingTableView.dataSource = self
            projectWaitingTableView.setRadius(radius: 15)
            projectWaitingTableView.dropShadow(color: .darkGray, opacity: 0.2, offSet: CGSize(width: 0, height: 3), radius: 2.5)
            projectWaitingTableView.clipsToBounds = true
            
            let animation = Animation.named("real_loading")
            loadingView.animation = animation
            loadingView.contentMode = .scaleAspectFit
            loadingView.loopMode = .loop
            loadingView.play()
            loadingView.isHidden = false
            
            roundSetFinishedLabel.isHidden = true
            }

           // 완료되는 시점의 코드 넣기 -> loadingView.stop()
            // Do any additional setup after loading the view.
        }
        

    // MARK: - extension

    extension MemberRoundSettingViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjectWaitingTableViewCell.identifier, for: indexPath) as! ProjectWaitingTableViewCell
            return cell
        }
        
    }

    extension MemberRoundSettingViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return projectWaitingTableView.bounds.height/3
        }
    }
