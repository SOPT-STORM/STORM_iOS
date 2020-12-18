//
//  SettingCodePopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SettingCodePopViewController: UIViewController {
    
    // MARK:- 변수 선언
    
    @IBOutlet weak var projectCodeTextField: UITextField!
    @IBOutlet weak var settingCodePopView: UIView!
    @IBOutlet weak var copyButton: UIButton!
    
    var delegate: PresentVC!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingCodePopView.layer.cornerRadius = 15
        settingCodePopView.clipsToBounds = true
        
        projectCodeTextField.text = ProjectSetting.shared.projectCode!
    }
    
    // MARK:- IBAction 선언
    
    @IBAction func createOkButtonDidTap(_ sender: UIButton) {
        
        
        self.dismiss(animated: false) {
            self.delegate.presentVC()
        }
        
    }
    
    @IBAction func copyButtonDidPress(_ sender: Any) {
        getCopiedText()
        
    }
    
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = projectCodeTextField.text
    }
}
