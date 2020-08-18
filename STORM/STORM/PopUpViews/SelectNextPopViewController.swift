//
//  SelectNextPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SelectNextPopViewController: UIViewController {
 
    @IBOutlet weak var roundInfoLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.cornerRadius = 10 
        
    }
    
    @IBAction func didPressCancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func didPressNextRound(_ sender: UIButton) {
        dismissViewControllers()
        
        guard let projectCode = ProjectSetting.shared.projectCode else {return}
        
        SocketIOManager.shared.socket.emit("nextRound", projectCode)
    }
    
    @IBAction func didPressFinishProject(_ sender: UIButton) {
        guard let projectCode = ProjectSetting.shared.projectCode else {return}
        
        print("실행1111")
        SocketIOManager.shared.socket.emit("finishProject", projectCode)
        
        guard let presentingVc = self.presentingViewController else {return}
        
        print("실행2222")
        self.dismiss(animated: false) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "projectFinalViewController") as? ProjectFinalViewController else {return}
            
            print("실행333333")
            let naviController = UINavigationController(rootViewController: vc)
            
            presentingVc.present(naviController, animated: false, completion: nil)
        }
        
    }
    
    func dismissViewControllers() {
        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)

//        guard let vc = self.presentingViewController else { return }
//
//        while (vc.presentingViewController != nil) {
//            print(vc)
//            print(vc.presentingViewController is HostRoundSettingViewController)
//            vc.dismiss(animated: true, completion: nil)
//        }
        
//        guard let vc = self.presentingViewController else { return }
//
//        while !(vc.presentingViewController is HostRoundSettingViewController) {
//            vc.dismiss(animated: true, completion: nil)
//        }
    }
}
    

