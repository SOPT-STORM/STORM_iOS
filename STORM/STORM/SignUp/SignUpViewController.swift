//
//  SignUpViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    // MARK:- IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdConfirmTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var serviceAgreeButton: UIButton!
    @IBOutlet weak var infoAgreeButton: UIButton!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var pwdErrorLabel: UILabel!
    
    @IBOutlet weak var passwdViewCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var emailViewCenterY: NSLayoutConstraint!
    
    var popViewDismissed: Bool?
    var canGoToNext: Bool?
    var serviceAgree: Bool?
    var infoAgree: Bool?
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationbar
        setSignUpNavi()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(didPressBackSignUp))
        
        // textfield cancel button
        emailTextField.clearButtonMode = .always
        emailTextField.clearButtonMode = .whileEditing
        
        pwdTextField.clearButtonMode = .always
        pwdTextField.clearButtonMode = .whileEditing
        pwdTextField.autocorrectionType = .no
        
        pwdConfirmTextField.clearButtonMode = .always
        pwdConfirmTextField.clearButtonMode = .whileEditing
        
        // error message
        emailErrorLabel.isHidden = true
        pwdErrorLabel.isHidden = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(popView),
                                               name: NSNotification.Name(rawValue: "OKButton"),
                                               object: nil)
        
        // 다음뷰 넘어갈 수 있는지
        canGoToNext = false
        
        emailTextField.addTarget(self, action: #selector(emailPasswordEditing), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(emailPasswordEditing), for: .editingChanged)
        pwdConfirmTextField.addTarget(self, action: #selector(emailPasswordEditing), for: .editingChanged)
        
        toolbarSetup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // shadow, radius
        emailTextField.cornerRadius = 10
        pwdTextField.cornerRadius = 10
        pwdConfirmTextField.cornerRadius = 10
        
        nextButton.addShadow(cornerRadus: 11, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
        
        // textfield padding
        emailTextField.addLeftPadding()
        pwdTextField.addLeftPadding()
        pwdConfirmTextField.addLeftPadding()
    }
    
    override func viewDidLayoutSubviews() {
        
//        // shadow, radius
//        emailTextField.cornerRadius = 10
//        pwdTextField.cornerRadius = 10
//        pwdConfirmTextField.cornerRadius = 10
//
//        nextButton.addShadow(cornerRadus: 11, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
//
//        // textfield padding
//        emailTextField.addLeftPadding()
//        pwdTextField.addLeftPadding()
//        pwdConfirmTextField.addLeftPadding()
    }
    
    // MARK:- @objc
    
    @objc func didPressBackSignUp() {
        
        if emailTextField.text != "" || pwdTextField.text != "" || pwdConfirmTextField.text != "" {
            guard let goBackPopUpVC = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "GoBackPopUp") as? GoBackPopUpViewController else {return}
            goBackPopUpVC.modalPresentationStyle = .overCurrentContext
            self.present(goBackPopUpVC, animated: false, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func popView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func emailPasswordEditing() {
        errorLabelCondition()
        buttonActivation()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        passwdViewCenterY.constant = -40
        emailViewCenterY.constant = -40
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func hideKeyboard(_ sender: Any){
        passwdViewCenterY.constant = 0
        emailViewCenterY.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        self.view.endEditing(true)
    }
    
    
    // MARK:- IBAction
    
    @IBAction func serviceAgreeButtonClicked(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "loginMaintainIcn"), for: .selected)
            sender.isSelected = true
            self.serviceAgree = true
        }
        else {
            sender.setImage(UIImage(named: "loginCheckboxIcn"), for: .normal)
            sender.isSelected = false
            self.serviceAgree = false
        }
        buttonActivation()
    }
    
    @IBAction func infoAgreeButtonClicked(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "loginMaintainIcn"), for: .selected)
            sender.isSelected = true
            self.infoAgree = true
        }
        else {
            sender.setImage(UIImage(named: "loginCheckboxIcn"), for: .normal)
            sender.isSelected = false
            self.infoAgree = false
        }
        buttonActivation()
    }
    @IBAction func goToServiceLink(_ sender: UIButton) {
        guard let url = URL(string: "https://stormbrainstorming.creatorlink.net/%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%80"), UIApplication.shared.canOpenURL(url) else {return}
        UIApplication.shared.open(url)
        
    }
    
    @IBAction func goToInfoLink(_ sender: UIButton) {
        guard let url = URL(string: "https://stormbrainstorming.creatorlink.net/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8"), UIApplication.shared.canOpenURL(url) else {return}
        UIApplication.shared.open(url)
    }
    
    
    
    @IBAction func nextButtonDidPressed(_ sender: UIButton) {
        if canGoToNext == true && serviceAgree == true && infoAgree == true {
            confirmEmailOverlap()
        }
    }
    // MARK:- 함수
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if emailTextField.isEditing || pwdTextField.isEditing || pwdConfirmTextField.isEditing {self.view.endEditing(true)}
        
        passwdViewCenterY.constant = 0
        emailViewCenterY.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func isValidEmail() -> Bool {
        if let email = emailTextField.text {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        } else {
            return false
        }
    }
    
    func confirmEmailOverlap() {
        guard let email = self.emailTextField.text else {return}
        NetworkManager.shared.confirmEmail(userEmail: email) { (response) in
            if response.status == 200 {
                if let nextVC = self.storyboard?.instantiateViewController(withIdentifier:
                                                                            "SignUpProfileVC") as? SignUpProfileViewController {
                    nextVC.userEmail = self.emailTextField.text
                    nextVC.userPwd = self.pwdTextField.text
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            } else if response.status == 600 {
                self.emailErrorLabel.text = "이미 사용 중인 이메일입니다"
                self.emailErrorLabel.isHidden = false
                self.nextButton.backgroundColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
            }
        }
    }
    
    func errorLabelCondition() {
        
        if !isValidEmail() && emailTextField.text != "" {
            emailErrorLabel.text = "이메일 형식이 올바르지 않습니다"
            emailErrorLabel.isHidden = false
        } else {
            emailErrorLabel.isHidden = true
        }
        
        if pwdTextField.text?.count ?? 0 < 8 && pwdTextField.text != "" {
            pwdErrorLabel.text = "8자 이상 입력해주세요"
            pwdErrorLabel.isHidden = false
        } else if pwdTextField.text != pwdConfirmTextField.text && pwdConfirmTextField.text != "" {
            pwdErrorLabel.text = "비밀번호가 일치하지 않습니다"
            pwdErrorLabel.isHidden = false
        } else {
            pwdErrorLabel.isHidden = true
        }
    }
    
    func buttonActivation() {
        if emailErrorLabel.isHidden == true && pwdErrorLabel.isHidden == true && emailErrorLabel.text != "" && pwdTextField.text != "" && pwdConfirmTextField.text != "" && serviceAgree == true && infoAgree == true {
            nextButton.backgroundColor = .stormRed
            canGoToNext = true
        } else {
            nextButton.backgroundColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
            canGoToNext = false
        }
    }
    
    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
        
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))
        
        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
        emailTextField.inputAccessoryView = toolbar
        pwdTextField.inputAccessoryView = toolbar
        pwdConfirmTextField.inputAccessoryView = toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.emailTextField {
            self.pwdTextField.becomeFirstResponder()
            
        } else if textField == self.pwdTextField {
            self.pwdConfirmTextField.becomeFirstResponder()
        }
        return true
    }
    
    func errorMessage() {
        
        if !(emailTextField.text?.contains("@") ?? false) {
            emailErrorLabel.isHidden = false
        } else {
            emailErrorLabel.isHidden = true
        }
        
        if pwdTextField.text?.count ?? 0 < 8 {
            pwdErrorLabel.text = "8자 이상 입력해주세요"
            pwdErrorLabel.isHidden = false
        }
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
