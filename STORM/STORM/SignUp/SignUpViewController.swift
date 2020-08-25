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
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var pwdErrorLabel: UILabel!
    
    var popViewDismissed: Bool?
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationbar
        setSignUpNavi()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backBtn" ), style: .plain, target: self, action: #selector(didPressBackSignUp))
        
        // shadow, radius
        emailTextField.cornerRadius = 10
        pwdTextField.cornerRadius = 10
        pwdConfirmTextField.cornerRadius = 10
        
        nextButton.addShadow(cornerRadus: 11, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
        
        // textfield cancel button
        emailTextField.clearButtonMode = .always
        emailTextField.clearButtonMode = .whileEditing
        
        pwdTextField.clearButtonMode = .always
        pwdTextField.clearButtonMode = .whileEditing
        
        pwdConfirmTextField.clearButtonMode = .always
        pwdConfirmTextField.clearButtonMode = .whileEditing
        
        // textfield padding
        emailTextField.addLeftPadding()
        pwdTextField.addLeftPadding()
        pwdConfirmTextField.addLeftPadding()
        
        // error message
        emailErrorLabel.isHidden = true
        pwdErrorLabel.isHidden = true
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(popView),
        name: NSNotification.Name(rawValue: "OKButton"),
        object: nil)
        
        
    }
    
    // MARK:- @objc
    
    @objc func didPressBackSignUp() {

            guard let goBackPopUpVC = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "GoBackPopUp") as? GoBackPopUpViewController else {return}
            goBackPopUpVC.modalPresentationStyle = .overCurrentContext
            self.present(goBackPopUpVC, animated: false, completion: nil)
    }
    
    @objc func popView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK:- IBAction
    
    @IBAction func nextButtonDidPressed(_ sender: UIButton) {
        confirmEmailOverlap()
    }
    // MARK:- 함수
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
                self.emailErrorLabel.text = "이미 사용 중인 이메일입니다."
                self.emailErrorLabel.isHidden = false
                self.nextButton.backgroundColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.emailTextField {
            if !(emailTextField.text?.contains("@") ?? false) {
                emailErrorLabel.text = "이메일 형식이 올바르지 않습니다."
                emailErrorLabel.isHidden = false
            } else {
                emailErrorLabel.isHidden = true
            }
            
        } else {
            if pwdTextField.text?.count ?? 0 < 8 {
                pwdErrorLabel.text = "8자 이상 입력해주세요."
                pwdErrorLabel.isHidden = false
            } else if pwdTextField.text != pwdConfirmTextField.text {
                pwdErrorLabel.text = "비밀번호가 일치하지 않습니다."
                pwdErrorLabel.isHidden = false
            } else {
                pwdErrorLabel.isHidden = true
            }
        }
        
        if emailErrorLabel.isHidden == true && pwdErrorLabel.isHidden == true && emailTextField.text != "" && pwdTextField.text != "" {
            nextButton.backgroundColor = .stormRed
        } else {
            nextButton.backgroundColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        }
        
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
            pwdErrorLabel.text = "8자 이상 입력해주세요."
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
