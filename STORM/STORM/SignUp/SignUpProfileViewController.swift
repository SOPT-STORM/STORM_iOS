//
//  SignUpProfileViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SignUpProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate { // 뒷화면 캡쳐 코드 아직. 안썼음
    
    // MARK:- IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK:- 변수
    
    let myPicker = UIImagePickerController()
    
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationbar
        self.navigationController?.setNaviBar()
        
        // shadow, radius
        nameTextField.cornerRadius = 10
        doneButton.addShadow(cornerRadus: 10, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
        
        // textfield cancel, padding
        nameTextField.clearButtonMode = .always
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.addLeftPadding()
        
        // error message
        errorLabel.isHidden = true
        
        // photo
        profileImage.cornerRadius = profileImage.frame.width / 2
        selectPhotoButton.addShadow(cornerRadus: selectPhotoButton.frame.width / 2, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.3, shadowRadius: 3)
        
    }
    
    // MARK:- IBAction
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        guard let cameraPopUpVC = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "CameraPopUp") as? CameraPopUpViewController else {return}
        
        // 0.1 초 늦게 캡쳐 (버튼 회색으로 캡쳐되는 것 방지)
        // 네비게이션 바까지 캡쳐
        // 네비게이션 바 제외하려면 self.view.asImage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            cameraPopUpVC.backImage = self.navigationController?.view.asImage()
            
            cameraPopUpVC.modalPresentationStyle = .fullScreen
            
            cameraPopUpVC.delegate = self
            
            self.present(cameraPopUpVC, animated: false, completion: nil)
        })
    }
    
    @IBAction func doneButtonDidPressed(_ sender: UIButton) {
        
        /*if let loginVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController {
            loginVC.modalPresentationStyle = .fullScreen
            self.navigationController?.popToViewController(loginVC, animated: true)
        }*/
        
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    // MARK:- 함수
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpProfileViewController: presentPhotoLibrary {
   func photoLibrary() {
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
}
