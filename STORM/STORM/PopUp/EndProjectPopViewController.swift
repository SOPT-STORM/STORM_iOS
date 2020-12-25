//
//  EndProjectPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class EndProjectPopViewController: UIViewController {
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var endProjectPopView: UIView!
    var presentingVC = ""
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endProjectPopView.layer.cornerRadius = 15
        
        endProjectPopView.clipsToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func endConfirmButtonDidTap(_ sender: UIButton) {
        if presentingVC == "roundSetting" {
            let rootVC = self.view.window?.rootViewController
            
            self.view.window?.rootViewController?.dismiss(animated: false, completion: {
                guard let navi = rootVC as? UINavigationController else {return}
                navi.popToRootViewController(animated: false)
            })
        } else if presentingVC == "roundStart"  {
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
        } else {
            let storyboard = UIStoryboard(name: "RoundFinished", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "projectFinalViewController") as? ProjectFinalViewController else {return}
            
            let naviController = UINavigationController(rootViewController: vc)
            naviController.modalPresentationStyle = .fullScreen
            
            self.present(naviController, animated: false, completion: nil)
        }
    }
    
    @IBAction func endCancelButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
