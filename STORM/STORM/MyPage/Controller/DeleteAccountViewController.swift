//
//  DeleteAccountViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var etcTextView: UITextView!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바
        self.setNaviTitle()
        self.view.tintColor = .stormRed
        
        // whiteView radius
        whiteView.roundCorners(corners: [.topRight, .topLeft], radius: 30.0)
        
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
        
        // error label
        errorMessageLabel.isHidden = true
        
    }
    
    // MARK:- IBAction
    
    @IBAction func toNextPage(_ sender: UIButton) {
        
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ensureDeleteVC") as? EnsureDeleteViewController else {return}
        
        // nextVC에 체크된 버튼의 정보 넘기기

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK:- 함수
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        return true
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height * 0.5
            }
        }
    }
    @objc func keyboardHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height * 0.5
            }
        }
    }
    
}
