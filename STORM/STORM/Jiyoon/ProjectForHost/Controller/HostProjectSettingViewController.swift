//
//  HostProjectSettingViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class HostProjectSettingViewController: UIViewController {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var hostMessageTextView: UITextView!
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameTextField.addTextFieldInset()
        projectNameTextField.delegate = self
        /*
        projectNameTextField.attributedPlaceholder = NSAttributedString(string:"Test Data for place holder", attributes:[NSAttributedString.Key.foregroundColor: UIColor.placeholderColor,NSAttributedString.Key.font :UIFont(name: "Noto Sans CJK KR Medium", size: 13)!]) */
        
        hostMessageTextView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 0)
        hostMessageTextView.text = "대기방의 참가자들에게 보여집니다."
        hostMessageTextView.textColor = UIColor.placeholderColor
        hostMessageTextView.font = UIFont(name: "Noto Sans CJK KR Medium", size: 13)
        hostMessageTextView.delegate = self
        

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController
            : HostProjectWaitingViewController =
            segue.destination as!
        HostProjectWaitingViewController
        
        destinationViewController.projectName =
            projectNameTextField.text!
        destinationViewController.hostMessage =
            hostMessageTextView.text!
    }
    
}
/*
 @IBAction func projectNameTextFieldEditingChanged(_ sender: UITextField) {
 if sender.text?.isEmpty ?? true {
 //placeholder text size set here
 projectNameTextField.textColor = UIColor.placeholderColor
 projectNameTextField.font = UIFont(name: "Noto Sans CJK KR Medium", size: 13)!
 } else {
 // When user starting typing
 projectNameTextField.textColor = UIColor.textDefaultColor
 projectNameTextField.font = UIFont(name: "Noto Sans CJK KR Medium", size: 13)!
 }
 }*/


// MARK: - Extension

extension HostProjectSettingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if hostMessageTextView.textColor == UIColor.placeholderColor {
            hostMessageTextView.text = nil
            hostMessageTextView.textColor = UIColor.textDefaultColor
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if hostMessageTextView.text.isEmpty {
            hostMessageTextView.text = "대기방의 참가자들에게 보여집니다."
            hostMessageTextView.textColor = UIColor.placeholderColor
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = hostMessageTextView.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return updatedText.count < 43
    }
    
    
}


extension HostProjectSettingViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = projectNameTextField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count < 21
    }
}
