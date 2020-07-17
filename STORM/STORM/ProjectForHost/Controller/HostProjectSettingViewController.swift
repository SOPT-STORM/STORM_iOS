//
//  HostProjectSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostProjectSettingViewController: UIViewController {
    
    static let identifier = "HostProjectSettingViewController"
    
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
        
//        self.navigationController?.setNaviBar()
        self.setNaviTitle()
    }
    
    // MARK: - IBAction
    
    @IBAction func addButtonDidPress(_ sender: UIButton) {
        
        if projectNameTextField.text!.isEmpty == false {
            let settingCodePopViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: SettingCodePopViewController.identifier) as! SettingCodePopViewController
            
            self.addChild(settingCodePopViewController)
            settingCodePopViewController.view.frame = self.view.frame
            settingCodePopViewController.didMove(toParent: self)
            self.view.addSubview(settingCodePopViewController.view)
            postProjectSetting()
        }
//        else {
//            // TODO: 토스트 띄워 말아
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func postProjectSetting() {
        guard let projectName = projectName, let comment = projectComment else { return }
        NetworkManager.shared.addProject(projectName: projectName, projectComment: comment, userIdx: self.userId) { (response) in
            print(response?.status)
            print(response?.message)
            print(response!.data?.project_idx)
            print(response!.data?.project_code!)
            UserDefaults.standard.set(response!.data!.project_idx, forKey: "projectIndex")
            UserDefaults.standard.set(response!.data?.project_code!, forKey: "projectCode")
        }
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
        if hostMessageTextView.text.isEmpty {
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
}
