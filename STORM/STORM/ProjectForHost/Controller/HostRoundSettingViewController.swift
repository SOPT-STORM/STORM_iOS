//
//  RoundSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostRoundSettingViewController: UIViewController {

    @IBOutlet weak var projectCodePasteView: UIView!
    @IBOutlet weak var toastPopupView: UIImageView!
    @IBOutlet weak var roundIndexLabel: UILabel!
    @IBOutlet weak var roundGoalTextField: UITextField!
    @IBOutlet weak var timeLimitTextField: UITextField!
    @IBOutlet weak var timeLimitPickerView: UIPickerView!
    @IBOutlet weak var roundSettingLabel: UILabel!
    @IBOutlet weak var stormLogoImage: UIImageView!
    
    @IBOutlet weak var textFieldYConstraint: NSLayoutConstraint!
    var timeLimitMinute: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toastPopupView.isHidden = true
        roundGoalTextField.addTextFieldInset()
        timeLimitTextField.addTextFieldInset()
        timeLimitPickerView.isHidden = true
        
        timeLimitPickerView.dataSource = self
        timeLimitPickerView.delegate = self

        timeLimitTextField.delegate = self
        timeLimitTextField.inputView = timeLimitPickerView
        registerKeyboardNotification()
        setGesture()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController
            : HostRoundStartViewController =
            segue.destination as!
        HostRoundStartViewController
        
        destinationViewController.roundGoalText =
            roundGoalTextField.text!
        destinationViewController.timeLimitText =
            timeLimitTextField.text!
    }
    

    @IBAction func confirmButton(_ sender: UIButton) {
    }
    
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
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return timeLimitPickerView.frame.size.width/3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let minute: Int = Int(row+1)

            return "\(minute)분"
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let minute: Int = Int(row+1)
        
        timeLimitTextField.text = "\(minute)분"
        timeLimitPickerView.isHidden = true
    }
}

// TODO: 왜 글씨가 2개가 겹쳐서 써지지..?ㅠㅠ
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
    roundSettingLabel.isHidden = true
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
    roundSettingLabel.isHidden = false
    stormLogoImage.isHidden = false
    UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
      self.view.layoutIfNeeded()
    })
  }
}
