//
//  MainViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var noProjectImg: UIImageView!
    
    @IBOutlet weak var textFieldBgView: UIView!
    
    @IBOutlet weak var codeText: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var dataArray: [ProjectWithDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kingFisherSetup()

        collectionView.delegate = self
        collectionView.dataSource = self
        codeText.delegate = self
        
        toolbarSetup()
        self.setNaviTitle()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "mypage_btn" ), style: .plain, target: self, action: #selector(didPressMyPage))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProjectList()
        loadSplashView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        codeText.text = nil
    }
    
    @objc func didPressMyPage() {
        guard let myPageVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPageVC") as? ProfileViewController else {return}
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
    
    @IBAction func didPressAddProject(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ProjectRound", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ProjectSettingVC") as? ProjectSettingViewController else {return}
        
        ProjectSetting.shared.mode = .host
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressMoreProject(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "allProjectViewController") as? AllProjectViewController else {return}
        
        vc.data = dataArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func kingFisherSetup() {
        //        KingfisherManager.shared.cache.clearMemoryCache()
        
        // 캐싱 메모리 300mb로 사용 제한
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 30000
    }
    
    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
                
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
        
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))

        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
        codeText.inputAccessoryView = toolbar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.codeText.endEditing(true)
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func fetchProjectList() {
        NetworkManager.shared.fetchProjectList { (response) in
            if response?.status != 200 || response?.data?.isEmpty == true {
                self.collectionView.isHidden = true
            }

            guard let data = response?.data else {return}

            self.dataArray = data
            self.collectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var idx = 0
        
        let data = self.dataArray[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectSummaryCell", for: indexPath) as? ProjectSummaryCell else {return UICollectionViewCell()}
        
        cell.projectName.text = data.project_name
        
        for card in data.card_list {
            if idx == 4 {
                break
            }
            
            if card.card_txt == nil {
                cell.addDrawingImg(url: URL(string: card.card_img!)!, index: idx)
            } else {
                cell.addMemo(text: card.card_txt!, index: idx)
            }

            idx += 1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.height
        return CGSize(width: height * 0.742, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let inset = self.view.frame.width * 0.0693
       return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.0427
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("여기 실행")
        let projectIndex = self.dataArray[indexPath.row].project_idx
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "projectFinalViewController") as? ProjectFinalViewController else {return}
        
        vc.projectIndex = projectIndex
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let code = textField.text else {return true}
    
        NetworkManager.shared.fetchProjectStatus(projectCode: code) { (result) in
            
            guard let response = result else {return}
            
            if response.status == 200 {
                let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
                guard let popup = storyboard.instantiateViewController(withIdentifier: "projectInfoPopUp") as? ProjectInfoPopUp else {return}
                
                ProjectSetting.shared.projectCode = code
                
                popup.projectName = response.data!.project_name
                popup.projectComment = response.data?.project_comment ?? ""
                popup.projectIndex = (response.data?.project_idx)!
                
                popup.modalPresentationStyle = .overCurrentContext
                self.present(popup, animated: false, completion: nil)
                } else {
                let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
                guard let popup = storyboard.instantiateViewController(withIdentifier: "oneLineMessagePopVC") as? OneLineMessagePopViewController else {return}
                
                popup.modalPresentationStyle = .overCurrentContext
                
                switch response.status {
                    case 202:
                        popup.message = response.message
                        self.present(popup, animated: false, completion: nil)
                    case 204:
                        popup.message = response.message
                        self.present(popup, animated: false, completion: nil)
                    case 409:
                        popup.message = response.message
                        self.present(popup, animated: false, completion: nil)
                    case 400:
                        popup.message = response.message
                        self.present(popup, animated: false, completion: nil)
                    default:
                        popup.message = "오류가 발생했습니다"
                        self.present(popup, animated: false, completion: nil)
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        return false
    }
}
