//
//  ProfileViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var userImageContainerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var editNameButton: UIButton!
    @IBOutlet weak var editPhotoButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    
    
    
    // MARK:- 변수 선언
    
    let myPicker = UIImagePickerController()
    var separatorView: UIView!
    
        
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        
        // 네비게이션 바
        self.setNaviTitle()
        self.view.tintColor = .stormRed
        
        // 테이블뷰 악세서리
        
        // 사용자 이미지, 이미지 변경 버튼 동그랗게
        userImageContainerView.addShadow(cornerRadus: userImageContainerView.frame.width / 2, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.3, shadowRadius: 7)
        userImageView.makeCircle()
        
        editPhotoButton.addShadow(cornerRadus: editPhotoButton.frame.width / 2, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.2, shadowRadius: 4)
        
        // whiteView 모서리 radius
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
        
        // 텍스트 필드
        userNameTextField.isUserInteractionEnabled = false
        userNameTextField.delegate = self
        
        // 이름 밑 회색 바
        separatorView = UIView(frame: CGRect(x: 37, y: (self.view.frame.height * 0.53) , width: self.view.frame.width * 0.8, height: 2.0))
        separatorView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        self.view.addSubview(separatorView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.photoLibrary()
    }
    
    // MARK:- IBAction 선언
    
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
    
    @IBAction func editName(_ sender: UIButton) {
        // 텍스트 필드 수정 가능
        userNameTextField.isUserInteractionEnabled = true
        userNameTextField.becomeFirstResponder()
        userNameTextField.textColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        separatorView.backgroundColor = .stormRed
    }
    
    
    // MARK:- 함수 선언
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        userNameTextField.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        separatorView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        userNameTextField.isUserInteractionEnabled = false
        
        // 배경 눌렀을 때 키보드 내려가도록 코드 추가
        
        // 이름 서버에 저장
        
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        /*case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "menuCell1", for:
            indexPath)
            
            return cell1*/
            
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "menuCell1", for:
            indexPath)
    
            return cell1
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "menuCell2", for:
            indexPath)

            return cell2
        default:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "menuCell3", for:
            indexPath)

            return cell3
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
