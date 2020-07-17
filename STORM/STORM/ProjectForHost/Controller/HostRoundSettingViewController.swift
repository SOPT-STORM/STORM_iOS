//
//  RoundSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

// TODO: 오토 다시 잡기 번개가 ㅈㄴ 이상해

class HostRoundSettingViewController: UIViewController {
    
    static let identifier = "HostRoundSettingViewController"
    
    var minute = Int()
    
    let projectIndex = UserDefaults.standard.integer(forKey: "projectIndex")
    
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundGoalTextField: UITextField!
    @IBOutlet weak var timeLimitTextField: UITextField!
    @IBOutlet weak var timeLimitPickerView: UIPickerView!
    @IBOutlet weak var roundIndexSetLabel: UILabel!
    @IBOutlet weak var stormLogoImage: UIImageView!
    @IBOutlet weak var pasteCodeImage: UIImageView!
    
    @IBOutlet weak var textFieldYConstraint: NSLayoutConstraint!
    //var timeLimitMinute: Int? =
    var roundGoal: String? { return roundGoalTextField.text }
    var roundTimeLimit: Int? { return minute }
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProjectInfo()
        getRoundIndex()
        roundGoalTextField.addTextFieldInset()
        timeLimitTextField.addTextFieldInset()
        timeLimitPickerView.isHidden = true
        
        timeLimitPickerView.dataSource = self
        timeLimitPickerView.delegate = self
        
        timeLimitTextField.delegate = self
        timeLimitTextField.inputView = timeLimitPickerView
        registerKeyboardNotification()
        setGesture()
        
        let tapPasteCodeImage = UITapGestureRecognizer(target: self, action: #selector(handlePasteCodeImage))
        pasteCodeImage.addGestureRecognizer(tapPasteCodeImage)


        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let destinationViewController
     : HostRoundStartViewController =
     segue.destination as!
     HostRoundStartViewController
     
     destinationViewController.roundGoalText =
     roundGoalTextField.text!
     destinationViewController.timeLimitText =
     timeLimitTextField.text!
     
     }*/
    
    
    // MARK: - IBAction
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        if roundGoalTextField.text?.isEmpty == false && timeLimitTextField.text?.isEmpty == false {
            postRoundSetting()
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "ProjectForHost", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: HostRoundStartViewController.identifier) as! HostRoundStartViewController

            viewController.modalTransitionStyle = .coverVertical
            self.present(viewController, animated: false, completion: nil)
        }
        
    }
    
    
    
    // MARK: - Send Data
    
    func postRoundSetting() { guard let roundGoal = roundGoal else { return }
        print(projectIndex)
        NetworkManager.shared.setRound(projectIdx: self.projectIndex, roundPurpose: roundGoal, roundTime: self.minute)
        { (response) in
            UserDefaults.standard.set(response?.data!, forKey: "roundIndex")
            print(response?.message)
            print(response?.status)
        }
    }
    
    // MARK: - Receive Data
    
    func getProjectInfo() {
        NetworkManager.shared.fetchProjectInfo(projectIdx: self.projectIndex) { (response) in
            self.projectNameLabel.text = response!.data.project_name
        }
    }
    
    func getRoundIndex() {
        NetworkManager.shared.fetchRoundCountInfo(projectIdx: self.projectIndex) { (response) in
            self.roundIndexSetLabel.text = "ROUND\(response!.data!) 설정"
        }
    }
    
    func getCopiedText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = (UserDefaults.standard.value(forKey: "projectCode") as! String)
        print("copied")
    }
    
    
    // MARK: - Add Gesture Recognizer for handling Keyboard
    
    func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        roundGoalTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Create Toast Popup View
    
    @objc func handlePasteCodeImage(sender: UITapGestureRecognizer) {
        print("tap111")
        UIPasteboard.general.string = UserDefaults.standard.value(forKey: "projectCode") as? String
        self.showToast(message: "참여코드가 복사되었습니다.", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (200/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
        getCopiedText()
    }
    
}

// MARK: - Extension

extension HostRoundSettingViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        timeLimitPickerView.isHidden = false
        return false
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
        return timeLimitPickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        minute = Int(row+1)
        
        return "\(minute)분"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        minute = Int(row+1)
        
        timeLimitTextField.text = "\(minute)분"
        timeLimitPickerView.isHidden = true
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
        
        textFieldYConstraint.constant = -keyboardHeight/2
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
        
        textFieldYConstraint.constant = 0
        roundIndexSetLabel.isHidden = false
        stormLogoImage.isHidden = false
        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}
