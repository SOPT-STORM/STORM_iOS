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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "myprojectBtnBack" ), style: .plain, target: self, action: #selector(back)) // 이 방법 밖에 없나....
        
        // 화면 가리는 문제
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        topConst = topConstOfIndex.constant
        
        // error label
        errorMessageLabel.isHidden = true
        
        //툴바
        toolbarSetup()
        
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
        etcTextView.text = "탈퇴 사유를 입력해주세요 (선택)"
        etcTextView.textColor = .systemGray2
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
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                topConstOfIndex.constant = -keyboardHeight+250
            }
        }
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
    }
    
    // MARK:- IBAction
    
    @IBAction func toNextPage(_ sender: UIButton) {
        confirmPassword()
    }
    
    // MARK:- 함수
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .systemGray
        textView.text = nil
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
    
    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
                    
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                    
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
            
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))

        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
        etcTextView.inputAccessoryView = toolbar
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
