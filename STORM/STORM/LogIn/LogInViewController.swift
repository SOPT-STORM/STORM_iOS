//
//  LogInViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:- IBOutlet
    
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var pwdView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK:- 변수
    
    var isAutoLogiIn: Bool = false
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigationbar
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // shadow, radius
        emailView.cornerRadius = 10
        pwdView.cornerRadius = 10
        loginButton.addShadow(cornerRadus: 11, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
        
        // error label
        errorLabel.isHidden = true
        
        // textfield clear button
        emailTextField.clearButtonMode = .always
        emailTextField.clearButtonMode = .whileEditing
        
        pwdTextField.clearButtonMode = .always
        pwdTextField.clearButtonMode = .whileEditing
    }
    
    // MARK:- IBAction
    
    @IBAction func loginButtonDidPressed(_ sender: UIButton) {
        // 일치하면 로그인 성공, 뷰 넘어감
        // 일치하지 않으면 "이메일/비밀번호를 확인해주세요" 문장 뜨도록 분기 처리
        guard let inputID = emailTextField.text else { return }
        guard let inputPWD = pwdTextField.text else { return }
    }
    
    @IBAction func signUpButtonDidPressed(_ sender: UIButton) {
        
        if let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpViewController {
            signUpVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(signUpVC, animated: true)
            print("다음뷰!")
        }
    }
    
    @IBAction func maintainLoginButtonDidPressed(_ sender: UIButton) {
        // 분기처리 안에 내용 추가하기 
        
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "loginMaintainIcn"), for: .normal)
            sender.isSelected = true
            self.isAutoLogiIn = true
        }
        else {
            sender.setImage(UIImage(named: "loginCheckboxIcn"), for: .normal)
            sender.isSelected = false
            self.isAutoLogiIn = false
        }
    }
    
    // MARK:- textfieldShouldReturn
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            textField.resignFirstResponder()
            self.pwdTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
