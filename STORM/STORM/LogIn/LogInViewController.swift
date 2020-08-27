//
//  LogInViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Lottie

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
    let animationView = AnimationView()
    var autoEmail: String?
    var autoPwd: String?
    var userIndex: Int?
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigationbar
        self.navigationController?.navigationBar.barTintColor = .clear
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//
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
        
        // 자동 로그인
        isAutoLogiIn = false
        if let email = UserDefaults.standard.string(forKey: "email"), let pwd = UserDefaults.standard.string(forKey: "pwd") {
            autoLogin(userEmail: email, userPwd: pwd)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSplashView()
    }
    
    // MARK:- viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }
    
    // MARK:- IBAction
    
    @IBAction func loginButtonDidPressed(_ sender: UIButton) {
        // 일치하면 로그인 성공, 뷰 넘어감
        logIn()
    }
    
    @IBAction func signUpButtonDidPressed(_ sender: UIButton) {
        
        // ishidden == true && nil 아니여야 함
        if let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpViewController {
            signUpVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(signUpVC, animated: true)
            print("다음뷰!")
        }
    }
    
    @IBAction func maintainLoginButtonDidPressed(_ sender: UIButton) {
        // 분기처리 안에 내용 추가하기 
        
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "loginMaintainIcn"), for: .selected)
            sender.isSelected = true
            self.isAutoLogiIn = true
        }
        else {
            sender.setImage(UIImage(named: "loginCheckboxIcn"), for: .normal)
            sender.isSelected = false
            self.isAutoLogiIn = false
        }
    }
    
    // MARK:- 함수
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 서버 연결 후
        // ishidden == true && nil 아니여야 함
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            textField.resignFirstResponder()
            self.pwdTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }

    func setup(){
        animationView.frame = view.bounds
        animationView.animation = Animation.named("login_0816")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.insertSubview(animationView, at: 0)
       }
    
    func logIn() {
        guard let userEmail = emailTextField.text, let userPwd = pwdTextField.text else { return }

        NetworkManager.shared.login(userEmail: userEmail, userPwd: userPwd) { (response) in
            
            let status = response.status
            print(status)
            
            if status == 200 {
                if self.isAutoLogiIn {
                    UserDefaults.standard.set(userEmail, forKey: "email")
                    UserDefaults.standard.set(userPwd, forKey: "pwd")
                }
                
                self.errorLabel.isHidden = true
                
                if let userIndex = response.data {
                    UserDefaults.standard.set(userIndex, forKey: "index")
                    print("로그인 유저 인덱스 \(userIndex)")
                }
                
                guard let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as? MainViewController else {return}
                let naviController = UINavigationController(rootViewController: mainVC)

                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                window?.rootViewController = naviController
                
            } else if status == 600 {
                self.errorLabel.isHidden = false
            }
        }
    }
    
    func autoLogin(userEmail: String, userPwd: String) { // 없대도 될듯
        
        NetworkManager.shared.login(userEmail: userEmail, userPwd: userPwd) { (response) in
            
            if response.status == 200 {
                
                self.errorLabel.isHidden = true
                
                if let userIndex = response.data {
                    UserDefaults.standard.set(userIndex, forKey: "index")
                    print(userIndex)
                }
                
                guard let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as? MainViewController else {return}
                let naviController = UINavigationController(rootViewController: mainVC)
                
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                window?.rootViewController = naviController
    
            } else if response.status == 600 {
                
                self.errorLabel.isHidden = false
            }
        }
    }
    
    
    
}
