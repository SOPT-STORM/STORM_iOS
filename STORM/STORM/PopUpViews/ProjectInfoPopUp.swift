//
//  ProjectInfoPopUp.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/19.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectInfoPopUp: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectCommentLabel: UILabel!
    
    lazy var projectName:String = ""
    lazy var projectComment:String = ""
    lazy var projectIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameLabel.text = projectName
        projectCommentLabel.text = projectComment
        
        popupView.cornerRadius = 15
        popupView.clipsToBounds = true
    
    }
    
    @IBAction func didPressConfirmBtn(_ sender: UIButton) {
        
        
        guard let presentingVC = self.presentingViewController else {return}
        
        self.dismiss(animated: false) {
            
            NetworkManager.shared.enterProject(projectIndex: self.projectIndex) { (response) in
                    
                if response?.status == 200 {
                    
                    let storyboard = UIStoryboard(name: "ProjectRound", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "RoundStartVC") as? RoundStartViewController, let projectCode = ProjectSetting.shared.projectCode else {return}
                    
                    SocketIOManager.shared.socket.emit("joinRoom", projectCode)
                    
                    ProjectSetting.shared.mode = .member
                    ProjectSetting.shared.projectIdx = self.projectIndex
                    ProjectSetting.shared.roundIdx = response?.data
                    
                    let naviController = UINavigationController(rootViewController: vc)
                    naviController.modalPresentationStyle = .fullScreen
                    presentingVC.present(naviController, animated: true, completion: nil)
            
                } else {
                    print(response?.status)
                    print("서버 오류")
                }
            }
            
            
        }
    }
    
    @IBAction func didPressCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    

}
