//
//  MainViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/08.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:- 변수 선언
    
    static let identifier = "MainViewController"
    private var projectList: [ParticipatedProject] = []
    
    // MARK:- IBOutlet 선언
    @IBOutlet weak var insertCodeView: UIView!
    @IBOutlet weak var participatedProjectCollectionView: UICollectionView!
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardList()
        
        // Do any additional setup after loading the view.
        let img = UIImage(named: "redNavigationBar")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let titmeImg = UIImage(named: "imgLogo")
        let imageView = UIImageView(image:titmeImg)
        self.navigationItem.titleView = imageView
        
        // MARK: CODE BAR
        
        insertCodeView.layer.cornerRadius = 10.0
        insertCodeView.clipsToBounds = false
        
        participatedProjectCollectionView.delegate = self
        participatedProjectCollectionView.dataSource = self
    }
    
    // MARK:- IBAction 함수
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        let pushVC = UIStoryboard.init(name: "ProjectForHost", bundle: nil).instantiateViewController(withIdentifier: "HostProjectSettingViewController")
        self.navigationController?.pushViewController(pushVC, animated: false)
    }
    
    @IBAction func viewMoreButtonDidTap(_ sender: UIButton) {
    }
    
    // MARK:- func 함수
    
    func invalidCodeEntered() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        let invalidCodePopViewController = mainStoryboard.instantiateViewController(withIdentifier: "invalidCodePopUp") as! UIViewController
        self.navigationController?.addChild(invalidCodePopViewController)
        //invalidCodePopViewController.view.frame = self.view.frame
        invalidCodePopViewController.view.frame = UIApplication.shared.keyWindow!.frame
        self.navigationController?.view.addSubview(invalidCodePopViewController.view)
        invalidCodePopViewController.didMove(toParent: self.navigationController)
        
        //invalidCodePopViewController.modalPresentationStyle = .fullScreen
        /*self.present(invalidCodePopViewController, animated: false)*/
    }
    
    private func setCardList() {
        let project1 = ParticipatedProject(title: "미래의 마스크", cardImageName1: "", cardImageName2: "", cardImageName3: "", cardImageName4: "")
        let project2 = ParticipatedProject(title: "미래의 마스크", cardImageName1: "", cardImageName2: "", cardImageName3: "", cardImageName4: "")
        
        projectList = [project1, project2]
        print("projectList.count", projectList.count)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let participatedProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipatedProjectCell.identifier, for: indexPath) as? ParticipatedProjectCell else { return UICollectionViewCell() }
        
        participatedProjectCell.set(projectList[indexPath.row])
        return participatedProjectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    } // 셀 좌우 간격 조정
    
    
}
