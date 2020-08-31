//
//  ProjectSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectSettingViewController: UIViewController {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var hostMessageTextView: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
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
        hostMessageTextView.font = UIFont(name: "NotoSansCJKkr-Medium", size: 13)
        hostMessageTextView.delegate = self
        
        toolbarSetup()
        setNaviTitle()

        // 지현 수정 프로젝트명 17자 제한
        projectNameTextField.addTarget(self, action: #selector(self.limitProjectName), for: .editingChanged)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(back))

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
        print(projectComment)
        guard let projectName = projectName, placeHolderLabel.isHidden == true else { return }
        NetworkManager.shared.addProject(projectName: projectName, projectComment: projectComment, userIdx: self.userId) { (response) in
            
            guard let status = response?.status else {return}
            
            if status == 200 {
                ProjectSetting.shared.projectIdx = response?.data?.project_idx
                ProjectSetting.shared.projectCode = response?.data?.project_code
                ProjectSetting.shared.projectName = projectName
                
                let settingCodePopViewController = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "settingCodePopVC") as! SettingCodePopViewController
                
                settingCodePopViewController.delegate = self
                settingCodePopViewController.modalPresentationStyle = .overCurrentContext
                
                self.present(settingCodePopViewController, animated: false, completion: nil)
            }
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
    
        // 지현 수정 프로젝트명 17자 제한
        @objc func limitProjectName() {
            
            guard let name = projectNameTextField.text else {return}

            if name.count > 17 {
                let limitName = String(name.prefix(17))
                projectNameTextField.text = limitName
            }
         }
    }

extension ProjectSettingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            placeHolderLabel.isHidden = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = hostMessageTextView.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return updatedText.count < 43
    }
    
    
}

extension ProjectSettingViewController: UITextFieldDelegate {
    
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

extension ProjectSettingViewController: PresentVC {
    func presentVC() {

        let roundSettingNaviController = UIStoryboard(name: "ProjectRound", bundle: nil).instantiateViewController(withIdentifier: "roundSettingNavi") as! UINavigationController
        
        roundSettingNaviController.modalPresentationStyle = .fullScreen
        self.present(roundSettingNaviController, animated: false, completion: nil)
    }
}
