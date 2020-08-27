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
    
    // MARK:- 변수 선언
    
    let myPicker = UIImagePickerController()
    var separatorView: UIView!
    var previousName: String?
    var previousImage: UIImage?
    var previousColor: UIColor?
    var img_flag: Int?
    var myPageInfo: MyPage?
    
        
    // MARK:- viewDidLoad 선언
    
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
        // basic image
        basicImageStackView.isHidden = true
        
        // 프로필 불러오기
        getProfile()
        // 전 이름
        previousName = userNameTextField.text
        // 전 사진
        previousImage = userImageView.image
        previousColor = userImageContainerView.backgroundColor
        
        //navigationItem.backBarButtonItem?.action = #selector(didPressBack)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "myprojectBtnBack" ), style: .plain, target: self, action: #selector(didPressBack))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 기본이미지 노티
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(basicImage),
                                               name: NSNotification.Name(rawValue: "SetBasicImage"),
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        // 사용자 이미지, 이미지 변경 버튼 동그랗게
        userImageContainerView.addShadow(cornerRadus: userImageContainerView.frame.width / 2, shadowOffset: CGSize(width: 0, height: -1.5), shadowOpacity: 0.16, shadowRadius: 4)
        userImageView.makeCircle()
        userImageView.layer.masksToBounds = true
        
        editPhotoButton.addShadow(cornerRadus: editPhotoButton.frame.width / 2, shadowOffset: CGSize(width: 0, height: 1), shadowOpacity: 0.16, shadowRadius: 2)
        
        // whiteView 모서리 radius
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
        
        // 이름 밑 회색 바
        separatorView = UIView(frame: CGRect(x: 37, y: (self.view.frame.height * 0.455) , width: self.view.frame.width * 0.8, height: 2.0))
        separatorView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        self.view.addSubview(separatorView)
    }
    
    // MARK:- @objc
    
    @objc func basicImage(){
        basicImageStackView.isHidden = false
        purpleButton.setImage(UIImage(named: "purple"), for: .normal)
        purpleButton.isSelected = true
        
        userImageContainerView.backgroundColor = .stormPurple
        userNameLabel.isHidden = false
        userImageView.image = nil
        img_flag = 1
    }
    
    @objc func didPressBack() {
        self.navigationController?.popViewController(animated: true)
        // 이름, 이미지 수정
        print("이게 안되는건가")
        if userNameTextField.text != previousName {
            modifyName()
        }
        if userImageView.image != previousImage || userImageContainerView.backgroundColor != previousColor {
            modifyImage()
        }
        
    }
    
    // MARK:- IBAction 선언
    
    // 사진변경
    @IBAction func editPhoto(_ sender: UIButton) {
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
            
            self.userImageView.image = nil
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
    
    
    
    // MARK:- 함수 선언
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if userNameTextField.isEditing {self.view.endEditing(true)}
    }
    
    // 프로필 가져오기
    func getProfile() {
        NetworkManager.shared.fetchMyPageInfo() { (response) in
            if response?.status == 200 {
                self.myPageInfo = response?.data
                
                guard let userName = self.myPageInfo?.user_name, let userImageFlag = self.myPageInfo?.user_img_flag else {return}
                self.userNameTextField.text = userName
                self.img_flag = userImageFlag
                
                if userImageFlag == 0 {
                    
                    guard let userImage = self.myPageInfo?.user_img else {return}
                    self.userImageView.kf.setImage(with: URL(string: userImage))
                    self.userNameLabel.isHidden = true
                    
                } else {
                    
                    let firstIndex = userName.index(userName.startIndex, offsetBy: 0)
                    let lastIndex = userName.index(userName.startIndex, offsetBy: 2)
                    self.userNameLabel.text = String(userName[firstIndex..<lastIndex])
                    self.userNameLabel.isHidden = false
                    
                    if userImageFlag == 1 {
                        self.userImageContainerView.backgroundColor = .stormPurple
                    } else if userImageFlag == 2 {
                        self.userImageContainerView.backgroundColor = .stormYellow
                    } else if userImageFlag == 3 {
                        self.userImageContainerView.backgroundColor = .stormRed
                    }
                    
                }
                print("조회 유저 인덱스, 이름, 플래그 \(userName),\(userImageFlag)")
                
                guard let status = response?.status else {return}
                print(status)
                
            }
        }
        
    }
    
    // 사진 변경 저장
    func modifyImage() {
        let userIdx = UserDefaults.standard.integer(forKey: "index")
        guard let imgFlag = self.img_flag, let img = self.userImageView.image else {return}
        NetworkManager.shared.modifyProfileImage(userImg: img, userImgFlag: imgFlag) {}
    }

    // 이름 변경 저장
    func modifyName() {
        print("함수호출")
        guard let userName = userNameTextField.text else {return}
        NetworkManager.shared.modifyProfileName(userName: userName) { (response) in
            let status = response?.status
            print("이름 수정 \(status ?? 0)")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userNameTextField.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        separatorView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        userNameTextField.isUserInteractionEnabled = false
        
        // 에러메세지
        if textField.text?.count ?? 0 < 2 {
            errorMessage.isHidden = false
            textField.text = previousName
        } else {
            errorMessage.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        userNameTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        let newLength = currentCharacterCount + string.count - range.length
        
        if range.length + range.location > currentCharacterCount {
            return false
        } else if range.location < 3 && range.length == 0 {
            userNameLabel.text = textField.text
        }
        
        
        return newLength <= 10
    }
    
    // 사용자 선택 이미지 가져오기
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
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
