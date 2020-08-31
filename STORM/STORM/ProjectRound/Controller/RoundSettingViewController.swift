//
//  RoundSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class RoundSettingViewController: UIViewController {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundGoalTextField: UITextField!
    @IBOutlet weak var timeLimitTextField: UITextField!
    @IBOutlet weak var roundIndexSetLabel: UILabel!
    @IBOutlet weak var stormLogoImage: UIImageView!
    
    @IBOutlet weak var pasteCodeImage: UIImageView!
    
    @IBOutlet weak var inputViewBotConst: NSLayoutConstraint!

    var minute:Int? = Int()
    var timeLimitPicker = UIPickerView()
    
    lazy var botConst: CGFloat = 0
    lazy var roundNumb = 0
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRoundIndex()
        fetchProjectInfo()
        roundGoalTextField.addTextFieldInset()
        timeLimitTextField.addTextFieldInset()
        
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
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(popToFinish),
        name: NSNotification.Name(rawValue: "ok"),
        object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit" ), style: .plain, target: self, action: #selector(didPressExit))
        
        // 지현 수정 라운드목표 24자 제한
        roundGoalTextField.addTarget(self, action: #selector(self.limitRoundName), for: .editingChanged)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//    
//        getRoundIndex()
//        minute = nil
//        roundGoalTextField.text = nil
//        timeLimitTextField.text = nil
//    }
    
    // 팝뷰로 이동
    @objc func didPressExit() {
        guard let exitPopUpVC = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "EndProjectPopViewController") as? EndProjectPopViewController else {return}
        exitPopUpVC.modalPresentationStyle = .overCurrentContext
        self.present(exitPopUpVC, animated: false, completion: nil)
    }
    
    // 최종정리뷰로 이동
    @objc func popToFinish(){
        let rootVC = self.view.window?.rootViewController
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            guard let navi = rootVC as? UINavigationController else {return}
            navi.popToRootViewController(animated: false)
        })
    }
    
    
    
    // 지현 수정 라운드목표 24자 제한
    @objc func limitRoundName() {
        
        guard let name = roundGoalTextField.text else {return}

        if name.count > 24 {
            let limitName = String(name.prefix(24))
            roundGoalTextField.text = limitName
        }
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        print("2라운드 실행 \(roundGoalTextField.text) \(timeLimitTextField.text)")
        if roundGoalTextField.text?.isEmpty == false && timeLimitTextField.text?.isEmpty == false {
            
            print("2라운드 실행2")
            self.postRoundSetting()
 
        }
    }
    
    
    // MARK: - Send Data
    
    func postRoundSetting() { guard let roundGoal = roundGoalTextField.text, let time = minute, let projectIdx = ProjectSetting.shared.projectIdx else { return }
        
        NetworkManager.shared.setRound(projectIdx: projectIdx, roundPurpose: roundGoal, roundTime: time)
        { (response) in
            
            print(response)
            
            if response?.status == 200 {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "ProjectRound", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "roundNavi") as! UINavigationController
                                
                vc.modalPresentationStyle = .fullScreen
                
                if self.roundNumb == 1 {
                    print("호스트 조인룸 실행 \(ProjectSetting.shared.projectCode!), \(self.roundNumb)")
//                SocketIOManager.shared.socket.emit("joinRoom", ProjectSetting.shared.projectCode!)
                    
                    SocketIOManager.shared.socket.emit("joinRoom", ProjectSetting.shared.projectCode!) {
                        print("조인룸 실행")
                        ProjectSetting.shared.roundIdx = response?.data!
                        self.present(vc, animated: false, completion: nil)
                    }
                }
                
                if self.roundNumb > 1 {
                guard let projectCode = ProjectSetting.shared.projectCode else {return}
                    SocketIOManager.shared.socket.emit("nextRound", projectCode) {
                        ProjectSetting.shared.roundIdx = response?.data!
                        self.present(vc, animated: false, completion: nil)
                    }
                }
                
//                ProjectSetting.shared.roundIdx = response?.data!
//                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - Receive Data
    
    func fetchProjectInfo() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: ProjectSetting.shared.projectIdx!) { (response) in
            self.projectNameLabel.text = response?.data?.project_name
        }
    }
    
    func getRoundIndex() {
        NetworkManager.shared.fetchRoundCountInfo(projectIdx: ProjectSetting.shared.projectIdx!) { (response) in
            
            guard let rooundIdx = response?.data else {return}
            self.roundIndexSetLabel.text = "ROUND \(rooundIdx) 설정"
            self.roundNumb = rooundIdx
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
        self.showToast(message: "참여코드가 복사되었습니다", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
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

extension RoundSettingViewController: UITextFieldDelegate {
        
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


extension RoundSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        
        return "\(minute!)분"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        minute = Int(row+1)
        
        timeLimitTextField.text = "\(minute!)분"
        timeLimitTextField.resignFirstResponder()
    }
}

extension RoundSettingViewController {
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
