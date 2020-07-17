//
//  SettingCodePopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SettingCodePopViewController: UIViewController {
    
    static let identifier = "SettingCodePopViewController"
    
    // MARK:- 변수 선언

    @IBOutlet weak var projectCodeTextField: UITextField!
    @IBOutlet weak var settingCodePopView: UIView!
    @IBOutlet weak var copyButton: UIButton!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingCodePopView.layer.cornerRadius = 15
//        settingCodePopView.addShadow(width: 1, height: 3, 0.2, 5)
        settingCodePopView.addRoundShadow(cornerRadius: 15)
        settingCodePopView.clipsToBounds = true
        
        projectCodeTextField.text = (UserDefaults.standard.value(forKey: "projectCode") as! String)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.showAnimate()
    }
    
     // MARK:- IBAction 선언
     
     @IBAction func createOkButtonDidTap(_ sender: UIButton) {
         self.dismiss(animated: false, completion: nil)

        let projectWaitingViewController = UIStoryboard(name: "ProjectForHost", bundle: nil).instantiateViewController(withIdentifier: HostRoundSettingViewController.identifier) as! HostRoundSettingViewController
         projectWaitingViewController.modalTransitionStyle = .coverVertical
         self.present(projectWaitingViewController, animated: false, completion: nil)

         
     }
    
    @IBAction func copyButtonDidPress(_ sender: Any) {
        getCopiedText()
        
    }
    

    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = projectCodeTextField.text
        print("copied")

    @IBAction func createOkButtonDidTap(_ sender: UIButton) {
        NotificationCenter.default.post(name: .buttonClickInPopup, object: nil)
        self.removeAnimate()

    }
    
    // MARK:- 함수 선언
    /*
    func getProjectCode() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: <#T##Int#>, completion: <#T##(ProjectInfoResponse?) -> Void#>)
    // TODO: projectWithCode 쓸지 projectWithIdx 쓸지 정하기.
    } */

}
