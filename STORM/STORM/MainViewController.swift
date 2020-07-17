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
    
    var dataArray: [ProjectWithDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        codeText.delegate = self
        
        toolbarSetup()
        
        self.setNaviTitle()
        
        NetworkManager.shared.fetchProjectList { (response) in

            guard let data = response?.data else {return}

            self.dataArray = data
        
            self.collectionView.reloadData()
        }
        
        self.navigationController?.navigationBar.topItem?.title = " "
    }
    
    @IBAction func didPressAddProject(_ sender: UIButton) {
        let pushVC = UIStoryboard(name: "ProjectForHost", bundle: nil).instantiateViewController(withIdentifier: HostProjectSettingViewController.identifier) as! HostProjectSettingViewController
        self.navigationController?.pushViewController(pushVC, animated: false)
        self.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func didPressMoreProject(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allProjectViewController") as! AllProjectViewController
        
        vc.data = dataArray
        self.navigationController?.pushViewController(vc, animated: true)
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
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.dataArray.count > 5 {
            return 5
        } else {
            return self.dataArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var idx = 0

        let data = self.dataArray[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectSummaryCell", for: indexPath) as! ProjectSummaryCell
        
        cell.addRoundShadow(cornerRadius: 10)
        
        cell.projectName.text = data.project_name
        
        for card in data.card_list {
            if idx == 4 {
                break
            }
            
            if card.card_txt == nil {
                print(card.card_img!)
                cell.addDrawingImg(url: URL(string: card.card_img!)!, index: idx)
            } else {
                cell.addMemo(text: card.card_txt!, index: idx)
            }

            idx += 1
        }
    
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.347
        return CGSize(width: width, height: width * 1.3385)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let inset = self.view.frame.width * 0.0693
       return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.0427
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return key pressed")
        textField.resignFirstResponder()
        return true
    }
}
