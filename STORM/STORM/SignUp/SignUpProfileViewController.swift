//
//  SignUpProfileViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class SignUpProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK:- IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userImageContainerView: UIView!
    
    @IBOutlet weak var topConstOfIndex: NSLayoutConstraint!
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var basicImageStackView: UIStackView!
    
    
    // MARK:- 변수
    
    let myPicker = UIImagePickerController()
    let MAX_LENGTH = 2
    var userEmail: String?
    var userPwd: String?
    var img_flag: Int?
    var circleImage: UIImage?
    var serverImage: UIImage?
    var topConst: CGFloat = 0
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationbar
        setSignUpNavi()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn"), style: .plain, target: self, action: #selector(back))
        
        // textfield cancel, padding
        nameTextField.clearButtonMode = .always
        nameTextField.clearButtonMode = .whileEditing
        
        // error message
        errorLabel.isHidden = true
        
        // basic image
        basicImage()
        

        // username 사진 위 두글자 제한
        nameTextField.addTarget(self, action: #selector(self.textFieldTextDid), for: .editingChanged)
        
        // 화면 가리는 문제
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        topConst = topConstOfIndex.constant

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 기본이미지 노티
        NotificationCenter.default.addObserver(self,
        selector: #selector(basicImage),
        name: NSNotification.Name(rawValue: "SetBasicImage"),
        object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        // shadow, radius
        nameTextField.cornerRadius = 10
        doneButton.addShadow(cornerRadus: 10, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
        
        // photo, photo button
        userImageContainerView.makeCircle()
        profileImage.makeCircle()
        selectPhotoButton.addShadow(cornerRadus: selectPhotoButton.frame.width / 2, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.3, shadowRadius: 3)
        profileImage.contentMode = .scaleAspectFill
        
        // textfield padding
        nameTextField.addLeftPadding()
    }
    
    // MARK:- @objc
    
    @objc func textFieldTextDidChange() {
        
        let name = nameTextField.text!
    
        if name.count > 2 {
            let name11 = String(name.prefix(2))
            
            userNameLabel.text = name11
        } else {
            userNameLabel.text = name
        }
     }
    
    @objc func basicImage(){
        basicImageStackView.isHidden = false
        purpleButton.setImage(UIImage(named: "purple"), for: .normal)
        purpleButton.isSelected = true
        
        userImageContainerView.backgroundColor = .stormPurple
        userNameLabel.isHidden = false
        profileImage.image = nil
        img_flag = 1
    }
    
    @objc func textFieldTextDid() {
        
        guard let name = nameTextField.text else {return}
    
        if name.count > 2 {
            let nameTwoWord = String(name.prefix(2))
            userNameLabel.text = nameTwoWord
        } else {
            if nameTextField.text != "" && name.count < 2 {
                errorLabel.isHidden = false
            } else {
                errorLabel.isHidden = true
            }
            userNameLabel.text = name
        }
        
        // 이름 10글자 제한
        if name.count > 10 {
            let nameTenWord = String(name.prefix(10))
            nameTextField.text = nameTenWord
        }
        
        // cangotonext
        if errorLabel.isHidden == true  {
            doneButton.backgroundColor = .stormRed
        } else {
            doneButton.backgroundColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        }
     }
    
    @objc func keyboardShow(notification: NSNotification) {
        if nameTextField.isEditing == true {
            topConstOfIndex.constant = -(self.view.frame.height * 0.08)
        }
    }
    
    @objc func hideKeyboard(_ sender: UITextField){
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
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
    
    @IBAction func colorButtonDidPressed(_ sender: UIButton) {
        if sender.isSelected == false {
            
            self.profileImage.image = nil
            self.userNameLabel.isHidden = false
            
            if sender == purpleButton {
                
                sender.setImage(UIImage(named: "purple"), for: .normal)
                yellowButton.setImage(UIImage(named: "yellowCircle"), for: .normal)
                redButton.setImage(UIImage(named: "redCircle"), for: .normal)
                
                self.userImageContainerView.backgroundColor = .stormPurple
                
                yellowButton.isSelected = false
                redButton.isSelected = false
                img_flag = 1
                
                
            } else if sender == yellowButton {
                
                sender.setImage(UIImage(named: "yellow"), for: .normal)
                purpleButton.setImage(UIImage(named: "purpleCircle"), for: .normal)
                redButton.setImage(UIImage(named: "redCircle"), for: .normal)
                
                self.userImageContainerView.backgroundColor = .stormYellow
                
                purpleButton.isSelected = false
                redButton.isSelected = false
                img_flag = 2
                
            } else {
                
                sender.setImage(UIImage(named: "red"), for: .normal)
                yellowButton.setImage(UIImage(named: "yellowCircle"), for: .normal)
                purpleButton.setImage(UIImage(named: "purpleCircle"), for: .normal)
                
                self.userImageContainerView.backgroundColor = .stormRed
                
                purpleButton.isSelected = false
                yellowButton.isSelected = false
                img_flag = 3
                
            }
            
            sender.isSelected = true
        }
    }
    
    
    @IBAction func doneButtonDidPressed(_ sender: UIButton) {
        guard let name = nameTextField.text else {return}
        if name.count >= 2 {
            signUp()
        }
        
    }
    
    
    // MARK:- 함수
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if nameTextField.isEditing {
            self.view.endEditing(true)
            hideKeyboard(nameTextField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        hideKeyboard(textField)
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
            
            yellowButton.setImage(UIImage(named: "yellowCircle"), for: .normal)
            yellowButton.isSelected = false
            purpleButton.setImage(UIImage(named: "purpleCircle"), for: .normal)
            purpleButton.isSelected = false
            redButton.setImage(UIImage(named: "redCircle"), for: .normal)
            redButton.isSelected = false
            
            basicImageStackView.isHidden = true
            userNameLabel.isHidden = true
            img_flag = 0
        }
        dismiss(animated: true, completion: nil)
    }
    
    func signUp() {
        
        if img_flag != 0 {
            circleImage = userImageContainerView.asImage()
            serverImage = circleImage
        } else {
            serverImage = profileImage.image
        }
        
        guard let userName = nameTextField.text, let profileImg = serverImage, let imgFlag = img_flag, let useremail = userEmail, let userpwd = userPwd else { return }
        
        NetworkManager.shared.signUp(userImg: profileImg, userName: userName, userEmail: useremail, userPwd: userpwd, userImgFlag: imgFlag){ (response) in
            
            if response.status == 200 {
       
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "doneSignUpVC") as? DoneSignUpViewController else {return}
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: true, completion: nil)
                
            } else {
                print(response.status)
            }
        }
    }
}

extension SignUpProfileViewController: presentPhotoLibrary {
   func photoLibrary() {
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
}
