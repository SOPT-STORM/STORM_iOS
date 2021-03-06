//
//  DeleteAccountViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var etcTextView: UITextView!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var topConstOfIndex: NSLayoutConstraint!
    
    
    var previousName: String?
    var topConst: CGFloat = 0
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바
        self.setNaviTitle()
        self.view.tintColor = .stormRed
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(back))
        
        
        // 화면 가리는 문제
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        topConst = topConstOfIndex.constant
        
        // error label
        errorMessageLabel.isHidden = true
        
        etcTextView.text = "탈퇴 사유를 입력해주세요 (선택)"
        etcTextView.textColor = .systemGray2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorMessageLabel.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        
        // whiteView radius
        whiteView.roundCorners(corners: [.topRight, .topLeft], radius: 30.0)
        moveView.roundCorners(corners: [.topRight, .topLeft], radius: 30.0)
        
        // button shadow & radius
        nextButton.addShadow(cornerRadus: 7, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 2)
        
        // textView inset & radius
        etcTextView.textContainerInset = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
        etcTextView.cornerRadius = 8
        
        // textField inset & clear button & radius
        pwdTextField.addLeftPadding()
        pwdTextField.clearButtonMode = .always
        pwdTextField.clearButtonMode = .whileEditing
        pwdTextField.cornerRadius = 8
    }
    
    // MARK:- @objc
    
    @objc func keyboardShow(notification: NSNotification) {
        if pwdTextField.isEditing == true {
            topConstOfIndex.constant = 5 //(self.view.frame.height * 0.05)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK:- IBAction
    
    @IBAction func toNextPage(_ sender: UIButton) {
        confirmPassword()
    }
    
    // MARK:- 함수
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "탈퇴 사유를 입력해주세요 (선택)" {
            textView.text = ""
            textView.textColor = .placeholderColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "탈퇴 사유를 입력해주세요 (선택)"
            textView.textColor = .systemGray2
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        hideKeyboard(textField)
        // 비밀번호 확인
        
        return true
    }
    
    func confirmPassword() {
        guard let userPwd = pwdTextField.text else { return }
        
        NetworkManager.shared.confirmPassword(userPwd: userPwd) { (response) in
            
            let status = response.status
            
            if status == 200 {
                self.errorMessageLabel.isHidden = true
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ensureDeleteVC") as? EnsureDeleteViewController else {return}
                nextVC.userPwd = userPwd
                nextVC.reason = self.etcTextView.text ?? ""
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else {
                self.errorMessageLabel.isHidden = false
            }
        }
    }
}
