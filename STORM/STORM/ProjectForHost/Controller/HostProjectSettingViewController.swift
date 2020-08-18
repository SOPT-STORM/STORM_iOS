//
//  HostProjectSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostProjectSettingViewController: UIViewController {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var hostMessageTextView: UITextView!
    
    var projectName: String? { return projectNameTextField.text }
    var projectComment: String? { return hostMessageTextView.text }
    var userId: Int = 1
    var projectIndex: Int = 1
    var projectCode: String = ""
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameTextField.addTextFieldInset()
        projectNameTextField.delegate = self
        
        projectNameTextField.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        projectNameTextField.textColor = UIColor.textDefaultColor
        
        hostMessageTextView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 0)
        hostMessageTextView.text = "대기방의 참가자들에게 보여집니다."
        hostMessageTextView.textColor = UIColor.placeholderColor
        hostMessageTextView.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        hostMessageTextView.delegate = self
        
        toolbarSetup()
        setNaviTitle()
    }
    
    // MARK: - IBAction
    
    @IBAction func addButtonDidPress(_ sender: UIButton) {
        if projectNameTextField.text!.isEmpty == false {
            addProject()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addProject() {
        guard let projectName = projectName, let comment = projectComment else { return }
        NetworkManager.shared.addProject(projectName: projectName, projectComment: comment, userIdx: self.userId) { (response) in
            
            print(response?.status)
            
            guard let status = response?.status else {return}
            
            if status == 200 {
                ProjectSetting.shared.projectIdx = response?.data?.project_idx
                ProjectSetting.shared.projectCode = response?.data?.project_code
                ProjectSetting.shared.projectName = projectName
                
                SocketIOManager.shared.socket.emit("joinRoom", ProjectSetting.shared.projectCode!)
                
                let settingCodePopViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "settingCodePopVC") as! SettingCodePopViewController
                
                settingCodePopViewController.delegate = self
                settingCodePopViewController.modalPresentationStyle = .overCurrentContext
                
                self.present(settingCodePopViewController, animated: false, completion: nil)
            }
            
//            print(response?.status)
//            print(response?.message)
//            print(response!.data?.project_idx)
//            print(response!.data?.project_code!)
//            ProjectSetting.shared.projectIdx = response?.data?.project_idx
//            ProjectSetting.shared.projectCode = response?.data?.project_code
//            UserDefaults.standard.set(response!.data!.project_idx, forKey: "projectIndex")
//            UserDefaults.standard.set(response!.data?.project_code!, forKey: "projectCode")
//            print(UserDefaults.standard.value(forKey: "projectCode"))
//            print(UserDefaults.standard.value(forKey: "projectIndex"))
        }
    }
    
    // MARK: - Set Keyboard Toolbar
    
    func toolbarSetup() {
            let toolbar = UIToolbar()
            toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
            toolbar.barTintColor = UIColor.white
                    
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                    
            let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
            
            let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))

            toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
            projectNameTextField.inputAccessoryView = toolbar
        hostMessageTextView.inputAccessoryView = toolbar
        
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.projectNameTextField.endEditing(true)
            self.hostMessageTextView.endEditing(true)
        }
        
        @objc func hideKeyboard(_ sender: Any){
            self.view.endEditing(true)
        }
    }

/*
 @IBAction func projectNameTextFieldEditingChanged(_ sender: UITextField) {
 if sender.text?.isEmpty ?? true {
 //placeholder text size set here
 projectNameTextField.textColor = UIColor.placeholderColor
 projectNameTextField.font = UIFont(name: "Noto Sans CJK KR Medium", size: 13)!
 } else {
 // When user starting typing
 projectNameTextField.textColor = UIColor.textDefaultColor
 projectNameTextField.font = UIFont(name: "Noto Sans CJK KR Medium", size: 13)!
 }
 }*/


// MARK: - Extension

extension HostProjectSettingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if hostMessageTextView.textColor == UIColor.placeholderColor {
            hostMessageTextView.text = nil
            hostMessageTextView.textColor = UIColor.textDefaultColor
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(hostMessageTextView.text.count)
        
        if hostMessageTextView.text.count == 0 {
            hostMessageTextView.text = "대기방의 참가자들에게 보여집니다."
            hostMessageTextView.textColor = UIColor.placeholderColor
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = hostMessageTextView.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return updatedText.count < 43
    }
    
    
}

extension HostProjectSettingViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = projectNameTextField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count < 21
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        projectNameTextField.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        projectNameTextField.textColor = UIColor.textDefaultColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HostProjectSettingViewController: PresentVC {
    func presentVC() {
//        let projectWaitingViewController = UIStoryboard(name: "ProjectForHost", bundle: nil).instantiateViewController(withIdentifier: "hostRoundSettingVC") as! HostRoundSettingViewController
        
        let roundSettingNaviController = UIStoryboard(name: "ProjectForHost", bundle: nil).instantiateViewController(withIdentifier: "roundSettingNavi") as! UINavigationController
        
        roundSettingNaviController.modalPresentationStyle = .fullScreen
        self.present(roundSettingNaviController, animated: false, completion: nil)
    }
}
