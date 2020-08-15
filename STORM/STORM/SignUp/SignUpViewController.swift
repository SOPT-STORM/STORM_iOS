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
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.setNaviBar()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        
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
    }
    
    // MARK:- IBAction
    
    @IBAction func nextButtonDidPressed(_ sender: UIButton) {
        // 아무 이상 없이 다음 버튼 누르면 다음 화면으로 전환
        // 이메일 형식이 올바르지 않거나
        // 비밀번호가 8자리 미만이거나
        // 비밀번호 확인에 실패하면
        // errror message 띄우고 뷰 전환 x
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier:
            "SignUpProfileVC") {
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    // MARK:- 함수
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.pwdTextField {
            textField.resignFirstResponder()
            self.pwdConfirmTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField {
    func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
}
