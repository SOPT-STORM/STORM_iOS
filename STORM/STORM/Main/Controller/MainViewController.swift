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
    let data = ["테스트테스트", "테스트2", "", ""]
    
    // MARK:- IBOutlet 선언
    @IBOutlet weak var insertCodeView: UIView!
    @IBOutlet weak var recentProjectCollectionView: UICollectionView!
    @IBOutlet weak var cardSlider: UISlider!
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 네비게이션 바 색, 로고
        
        let img = UIImage(named: "redNavigationBar")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let titmeImg = UIImage(named: "imgLogo")
        let imageView = UIImageView(image:titmeImg)
        self.navigationItem.titleView = imageView
        
        // MARK: 코드입력 바
        
        insertCodeView.layer.cornerRadius = 10.0
        insertCodeView.clipsToBounds = false
        
        // MARK: 슬라이더 바
        
        cardSlider.thumbTintColor = .clear
        cardSlider.maximumTrackTintColor = UIColor(red: 245.0/255.0, green: 202.0/255.0, blue: 110.0/255.0, alpha: 0.3)
        
        // MARK: Nib register
        recentProjectCollectionView.register(UINib(nibName: "RecentProjectCardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: RecentProjectCardCollectionViewCell.identifier)
        recentProjectCollectionView.delegate = self
        recentProjectCollectionView.dataSource = self
        recentProjectCollectionView.clipsToBounds = false
    }
    
    // MARK:- IBAction 함수
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func viewMoreButtonDidTap(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "MainView", bundle: nil)
        let moreProjectViewController = mainStoryboard.instantiateViewController(withIdentifier: "viewMoreVC") as! UIViewController
        moreProjectViewController.modalPresentationStyle = .fullScreen
        
        self.present(moreProjectViewController, animated: false, completion: nil)
    }
    
    
    // MARK:- func 함수
    
    func invalidCodeEntered() {
        let popupStoryboard: UIStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        let invalidCodePopViewController = popupStoryboard.instantiateViewController(withIdentifier: "invalidCodePopUp") as! UIViewController
        self.navigationController?.addChild(invalidCodePopViewController)
        //invalidCodePopViewController.view.frame = self.view.frame
        invalidCodePopViewController.view.frame = UIApplication.shared.keyWindow!.frame
        self.navigationController?.view.addSubview(invalidCodePopViewController.view)
        invalidCodePopViewController.didMove(toParent: self.navigationController)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        // 수정 해야 함
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let recentProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentProjectCardCollectionViewCell.identifier, for: indexPath) as? RecentProjectCardCollectionViewCell else { return UICollectionViewCell() }
        
        //recentProjectCell.heightConstraint = 20
        
        //recentProjectCell.present = { [unowned self]
         // 변수가 함수를 담고 있기 때문에 메모리를 크게 차지함
         // 뷰컨트롤러가 셀을 참조를 하고 있는데 이 셀 안에 있는 클로저 변수를 사용중
            // retain cycle 중이기 때문에 계속해서 돌면 안되기 때문ㅇ ㅔstrong 사용하면 안됨
            // weak는 약한 참조, unowned 미소유 참조임
            // weak는 참조되는 다른 객체의 생명 주기가 짧을 때 사용
            // 미소유 참조는 나랑 같은 생명주기가 유지되거나 더 길 때 사용
            // 내 경우는 실행이 되고나서 바로 메모리가 해제 되어야 하는 경우는 x
        
        
        return recentProjectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    } // 셀 좌우 간격 조정
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recentProjectCollectionView.frame.width, height: recentProjectCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 27, left: 27, bottom: 0, right: 27)
    }
}

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 5))
    }
}
