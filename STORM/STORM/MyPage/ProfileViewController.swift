//
//  ProfileViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var userImageContainerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var editNameButton: UIButton!
    @IBOutlet weak var editPhotoButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var basicImageStackView: UIStackView!
    
    // MARK:- 변수
    
    let myPicker = UIImagePickerController()
    var separatorView: UIView!
    var previousName: String?
    var previousImage: UIImage?
    var previousColor: UIColor?
    var img_flag: Int?
    var myPageInfo: MyPage?
    var isPhotoChanged: Bool?
    
    private var isFirstLayoutSubviews: Bool = true
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //delegate
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self

        // 네비게이션 바
        self.setNaviTitle()
        self.view.tintColor = .stormRed

        // 유저 이미지
        userImageView.contentMode = .scaleAspectFill

        // 텍스트 필드
        userNameTextField.isUserInteractionEnabled = false
        userNameTextField.delegate = self

        // 2자 이상 입력해주세요.
        errorMessage.isHidden = true

        // 사진 변경 여부
        isPhotoChanged = false

        // navigationItem.backBarButtonItem?.action = #selector(didPressBack)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(didPressBack))

        // username 사진 위 두글자 제한
        userNameTextField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)

        self.basicImageStackView.isHidden = true
        self.userNameLabel.isHidden = true
//
        OperationQueue().addOperation {
            self.getProfile()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 기본이미지 노티
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(basicImage),
                                               name: NSNotification.Name(rawValue: "SetBasicImage"),
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        guard isFirstLayoutSubviews else { return }

        // 사용자 이미지, 이미지 변경 버튼 동그랗게
        userImageContainerView.addShadow(cornerRadus: userImageContainerView.frame.width / 2, shadowOffset: CGSize(width: 0, height: -1.5), shadowOpacity: 0.16, shadowRadius: 4)

//        userImageContainerView.layer.masksToBounds = true

//        userImageView.makeCircle()
        userImageView.layer.cornerRadius = userImageContainerView.frame.width / 2
        userImageView.layer.masksToBounds = true

        //editPhotoButton.cornerRadius = editPhotoButton.frame.width / 2

        // whiteView 모서리 radius
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)

        // 이름 밑 회색 바
        separatorView = UIView(frame: CGRect(x: 37, y: (self.view.frame.height * 0.48) , width: self.view.frame.width * 0.8, height: 2.0))
        separatorView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        self.view.addSubview(separatorView)
        isFirstLayoutSubviews = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- @objc
    
    @objc func basicImage(){
        basicImageStackView.isHidden = false
        purpleButton.setImage(UIImage(named: "purple"), for: .normal)
        purpleButton.isSelected = true
        
        userImageContainerView.backgroundColor = .stormPurple
        userNameLabel.isHidden = false
        userImageView.isHidden = true
        isPhotoChanged = true
        img_flag = 1
        
        if let name = userNameTextField.text {
            setTwoWords(name: name)
        }
    }
    
    @objc func didPressBack() {
        // 이미지 저장 & 이름 저장 분기처리
        guard let userNameCount = userNameTextField.text?.count else {return}
        if userNameCount >= 2 {
            self.navigationController?.popViewController(animated: true)
            
            guard let now = userNameTextField.text, let previous = previousName else {return}
            let nowTwoWord = String(now.prefix(2)), previousTwoWord = String(previous.prefix(2))
            
            if now != previous {
                modifyName()
                if userImageView.isHidden == true && nowTwoWord != previousTwoWord {
                    modifyImage()
                }
            } else if isPhotoChanged == true {
                modifyImage()
            }
        }
    }
    
    @objc func textFieldTextDidChange() {
        // 이미지 속 레이블은 2글자 제한, 텍스트필드는 10글자 제한
        guard let name = userNameTextField.text else {return}
        
        if name.count > 2 {
            let nameTwoWord = String(name.prefix(2))
            userNameLabel.text = nameTwoWord
        } else {
            userNameLabel.text = name
        }
        
        if name.count > 10 {
            let nameTenWord = String(name.prefix(10))
            userNameTextField.text = nameTenWord
        }
    }
    
    @objc func hideKeyboard(_ sender: UITextField){
        self.view.endEditing(true)
    }
    
    // MARK:- IBAction 선언
    
    // 사진변경
    @IBAction func editPhoto(_ sender: UIButton) {
        guard let cameraPopUpVC = UIStoryboard(name: "PopUp", bundle: nil).instantiateViewController(withIdentifier: "CameraPopUp") as? CameraPopUpViewController else {return}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            cameraPopUpVC.backImage = self.navigationController?.view.asImage()
            
            cameraPopUpVC.modalPresentationStyle = .overCurrentContext
            
            cameraPopUpVC.delegate = self
            self.present(cameraPopUpVC, animated: false, completion: nil)
        })
        
        
    }
    
    // 이름변경
    @IBAction func editName(_ sender: UIButton) {
        // 텍스트 필드 수정 가능
        userNameTextField.isUserInteractionEnabled = true
        userNameTextField.becomeFirstResponder()
        userNameTextField.textColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        separatorView.backgroundColor = .stormRed
    }
    
    // 기본이미지 색 선택
    @IBAction func colorButtonDidPressed(_ sender: UIButton) {
        if sender.isSelected == false {
            
            self.userImageView.isHidden = true
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
            isPhotoChanged = true
            sender.isSelected = true
        }
    }
    
    
    
    // MARK:- 함수 선언
    
    func setTwoWords(name: String) {
        let firstIndex = name.index(name.startIndex, offsetBy: 0)
        let lastIndex = name.index(name.startIndex, offsetBy: 2)
        self.userNameLabel.text = String(name[firstIndex..<lastIndex])
    }
    
    // 프로필 가져오기
    func getProfile() {
        NetworkManager.shared.fetchMyPageInfo() { (response) in
            if response?.status == 200 {
                self.myPageInfo = response?.data
                
                guard let userName = self.myPageInfo?.user_name, let userImageFlag = self.myPageInfo?.user_img_flag else {return}
                
                DispatchQueue.main.async {
                    
                    self.userNameTextField.text = userName
                    self.previousName = userName
                    self.img_flag = userImageFlag
                    
                    if userImageFlag == 0 {
                        
                        guard let userImage = self.myPageInfo?.user_img else {return}
                        self.userImageView.kf.setImage(with: URL(string: userImage))
                    } else {
                        
                        self.basicImageStackView.isHidden = false
                        self.setTwoWords(name: userName)
                        self.userNameLabel.isHidden = false
                        
                        if userImageFlag == 1 {
                            self.userImageContainerView.backgroundColor = .stormPurple
                            self.purpleButton.setImage(UIImage(named: "purple"), for: .normal)
                        } else if userImageFlag == 2 {
                            self.userImageContainerView.backgroundColor = .stormYellow
                            self.yellowButton.setImage(UIImage(named: "yellow"), for: .normal)
                        } else if userImageFlag == 3 {
                            self.userImageContainerView.backgroundColor = .stormRed
                            self.redButton.setImage(UIImage(named: "red"), for: .normal)
                        }
                        
                        self.previousColor = self.userImageContainerView.backgroundColor
                        
                    }
                }
            }
        }
        
    }
    
    // 사진 변경 저장
    func modifyImage() {
        
        guard let imgFlag = self.img_flag  else {return}
        if basicImageStackView.isHidden { //이미지
            guard let img = self.userImageView.image else {return}
            NetworkManager.shared.modifyProfileImage(userImg: img, userImgFlag: imgFlag) {}
        } else {
            let img = self.userImageContainerView.asImage()
            NetworkManager.shared.modifyProfileImage(userImg: img, userImgFlag: imgFlag) {}
        }
    }
    
    // 이름 변경 저장
    func modifyName() {
        guard let userName = userNameTextField.text else {return}
        NetworkManager.shared.modifyProfileName(userName: userName) { (response) in
        }
    }
    
    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
        
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))
        
        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
        userNameTextField.inputAccessoryView = toolbar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if userNameTextField.isEditing {self.view.endEditing(true)}
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userNameTextField.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        separatorView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        userNameTextField.isUserInteractionEnabled = false
        
        // 에러메세지
        if textField.text?.count ?? 0 < 2 {
            errorMessage.isHidden = false
        } else {
            errorMessage.isHidden = true
            guard let now = userNameTextField.text, let previous = previousName else {return}
            if  now != previous {
                self.showToast(message: "사용자 이름이 변경되었습니다", frame: CGRect(x: self.view.center.x, y: self.view.frame.height * (690/812) , width: self.view.frame.width * (215/375), height: self.view.frame.height * (49/812)))
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
    
    // 사용자 선택 이미지 가져오기
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.isHidden = false
            userImageView.image = image
            
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
        isPhotoChanged = true
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "menuCell1", for:
                                                        indexPath)
            return cell1
        default:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "menuCell2", for:
                                                        indexPath)
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let popupStoryBoard: UIStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
            guard let logoutPopUp = popupStoryBoard.instantiateViewController(withIdentifier: "LogOutPopUp") as? LogoutPopUpViewController else {return}
            
            logoutPopUp.modalPresentationStyle = .overCurrentContext
            self.present(logoutPopUp, animated: false, completion: nil)
            
        } else if indexPath.section == 1 {
            guard let deleteVC = storyboard?.instantiateViewController(withIdentifier: "DeleteAccountVC") as? DeleteAccountViewController else {return}
            
            deleteVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(deleteVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ProfileViewController: presentPhotoLibrary {
    func photoLibrary() {
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
}
