//
//  RoundSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostRoundSettingViewController: UIViewController {
    
    

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundGoalTextField: UITextField!
    @IBOutlet weak var timeLimitTextField: UITextField!
    @IBOutlet weak var roundIndexSetLabel: UILabel!
    @IBOutlet weak var stormLogoImage: UIImageView!
    
    @IBOutlet weak var pasteCodeImage: UIImageView!
    
    @IBOutlet weak var inputViewBotConst: NSLayoutConstraint!

    var minute = Int()
    var timeLimitPicker = UIPickerView()
    var roundGoal: String? { return roundGoalTextField.text }
    var roundTimeLimit: Int? { return minute }
    lazy var botConst: CGFloat = 0
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProjectInfo()
        getRoundIndex()
        roundGoalTextField.addTextFieldInset()
        timeLimitTextField.addTextFieldInset()
//        timeLimitPickerView.isHidden = false
        
        roundGoalTextField.delegate = self
        
        timeLimitPicker.dataSource = self
        timeLimitPicker.delegate = self
        
        timeLimitTextField.delegate = self
        timeLimitTextField.inputView = timeLimitPicker
        timeLimitTextField.tintColor = .clear
        
        
        registerKeyboardNotification()
        setGesture()
        toolbarSetup()
        setNaviTitle()
        
        botConst = inputViewBotConst.constant
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit" ), style: .plain, target: self, action: #selector(didPressExit))
    }
    
    @objc func didPressExit() {

        let rootVC = self.view.window?.rootViewController
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            guard let navi = rootVC as? UINavigationController else {return}
            navi.popToRootViewController(animated: false)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        if roundGoalTextField.text?.isEmpty == false && timeLimitTextField.text?.isEmpty == false {
//            NetworkManager.shared.enterRound(roundIdx: ProjectSetting.shared.roundIdx!) { (response) in
//               print(response?.status)
//
//                if response?.status == 200 {
//                    self.postRoundSetting()
//                }
//            }
            
            self.postRoundSetting()
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "ProjectForHost", bundle: nil)
//            let viewController = storyBoard.instantiateViewController(withIdentifier: "hostRoundStartVC") as! HostRoundStartViewController
//
//            viewController.modalTransitionStyle = .coverVertical
//            self.present(viewController, animated: false, completion: nil)
        }
    }
    
    
    // MARK: - Send Data
    
    func postRoundSetting() { guard let roundGoal = roundGoal else { return }
//        print(projectIndex, minute)
        
        let projectIdx = ProjectSetting.shared.projectIdx!
        
        NetworkManager.shared.setRound(projectIdx: projectIdx, roundPurpose: roundGoal, roundTime: self.minute)
        { (response) in
//            UserDefaults.standard.set(response?.data!, forKey: "roundIndex")
            
//            ProjectSetting.shared.roundIdx = response?.data
//            print(response?.message)
//            print(response?.status)
            
            if response?.status == 200 {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "ProjectForHost", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "hostRoundStartVC") as! HostRoundStartViewController
//
//                vc.modalTransitionStyle = .coverVertical
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "ProjectForHost", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "roundNavi") as! UINavigationController
                                
                vc.modalPresentationStyle = .fullScreen
                
                print("룸코드 \(ProjectSetting.shared.projectCode!)")
                
                SocketIOManager.shared.socket.emit("roundSetting", ProjectSetting.shared.projectCode!)
                
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - Receive Data
    
    func fetchProjectInfo() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: ProjectSetting.shared.projectIdx!) { (response) in
            self.projectNameLabel.text = response?.data.project_name
        }
    }
    
    func getRoundIndex() {
        NetworkManager.shared.fetchRoundCountInfo(projectIdx: ProjectSetting.shared.projectIdx!) { (response) in
            
            guard let rooundIdx = response?.data else {return}
            self.roundIndexSetLabel.text = "ROUND\(rooundIdx) 설정"
        }
    }
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
//        pasteboard.string = (UserDefaults.standard.value(forKey: "projectCode") as! String)
        pasteboard.string = ProjectSetting.shared.projectCode!
    }
    
    
    // MARK: - Add Gesture Recognizer for handling Keyboard
    
    func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Create Toast Popup View
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        UIPasteboard.general.string = ProjectSetting.shared.projectCode!
        self.showToast(message: "참여코드가 복사되었습니다.", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
        getCopiedText()
    }
    
    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
                
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
        
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))

        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
        roundGoalTextField.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
    }
    
}

// MARK: - Extension

extension HostRoundSettingViewController: UITextFieldDelegate {
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == timeLimitTextField{
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        roundGoalTextField.resignFirstResponder()
        return true
    }
}


extension HostRoundSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return timeLimitPicker.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        minute = Int(row+1)
        
        return "\(minute)분"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        minute = Int(row+1)
        
        timeLimitTextField.text = "\(minute)분"
        timeLimitTextField.resignFirstResponder()
    }
}

extension HostRoundSettingViewController {
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardSize.height
        
        inputViewBotConst.constant = -keyboardHeight - 20
        roundIndexSetLabel.isHidden = true
        stormLogoImage.isHidden = true
        
        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        inputViewBotConst.constant = botConst
        roundIndexSetLabel.isHidden = false
        stormLogoImage.isHidden = false
        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}
