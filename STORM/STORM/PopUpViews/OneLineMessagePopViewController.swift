//
//  OneLineMessagePopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class OneLineMessagePopViewController: UIViewController {

    @IBOutlet weak var invalidCodePopView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var message: String = ""
    
    lazy var presentingVC = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presentingVC == "roundMeetingVC" {
        self.button.setTitle("프로젝트 종료", for: .normal)
        }
        
        messageLabel.text = message
        
        invalidCodePopView.layer.cornerRadius = 15
        invalidCodePopView.clipsToBounds = true
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func didPressDismiss(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func okButtonDidTap(_ sender: UIButton) {

        if presentingVC == "roundMeetingVC" {
            
            guard let projectCode = ProjectSetting.shared.projectCode else {return}
            
            SocketIOManager.shared.socket.emit("finishProject", projectCode)
            
            NetworkManager.shared.finishProject { (response) in
            }
            
            guard let presentingVc = self.presentingViewController else {return}
            
            self.dismiss(animated: false) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "projectFinalViewController") as? ProjectFinalViewController else {return}
                
                let naviController = UINavigationController(rootViewController: vc)
                naviController.modalPresentationStyle = .fullScreen
                
                presentingVc.present(naviController, animated: false, completion: nil)
            }
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}
