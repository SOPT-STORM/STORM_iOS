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
    
    lazy var roundNumb = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.cornerRadius = 10
        roundInfoLabel.text = "ROUND \(roundNumb) 종료"
    }
    
    @IBAction func didPressCancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func didPressNextRound(_ sender: UIButton) {
        
        guard let projectCode = ProjectSetting.shared.projectCode else {return}
        
        SocketIOManager.shared.socket.emit("prepareNextRound", projectCode)
        
        dismissViewControllers()
    }
    
    @IBAction func didPressFinishProject(_ sender: UIButton) {
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
    }
    
    func dismissViewControllers() {

        let rootVC = self.view.window?.rootViewController

        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            guard let navi = rootVC as? UINavigationController else {return}
            navi.popToRootViewController(animated: false)
            
            let roundSettingNaviController = UIStoryboard(name: "ProjectRound", bundle: nil).instantiateViewController(withIdentifier: "roundSettingNavi") as! UINavigationController
            
            roundSettingNaviController.modalPresentationStyle = .fullScreen
            navi.present(roundSettingNaviController, animated: false, completion: nil)
        })
    }
}
    

