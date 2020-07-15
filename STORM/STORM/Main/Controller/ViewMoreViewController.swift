//
//  ViewMoreViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ViewMoreViewController: UIViewController {
    
    // MARK:- IBOutlet 선언

    @IBOutlet weak var recentProjectCollectionView: UICollectionView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: 네비게이션 바 색, 로고
        self.navigationController?.setNavigationBar()
        
        let backButton = UIBarButtonItem()
        //backButton.image = UIImage(named: "imageName") //Replaces title
        backButton.setBackgroundImage(UIImage(named: "seemoreCard1BtnBack"), for: .normal, barMetrics: .default) // Stretches image
        navigationItem.setLeftBarButton(backButton, animated: false)
        
        let titmeImg = UIImage(named: "imgLogo")
        let imageView = UIImageView(image:titmeImg)
        self.navigationItem.titleView = imageView
        
        // MARK: Nib register
        
        recentProjectCollectionView.register(UINib(nibName: "RecentProjectCardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: RecentProjectCardCollectionViewCell.identifier)
        recentProjectCollectionView.delegate = self
        recentProjectCollectionView.dataSource = self
        
        recentProjectCollectionView.clipsToBounds = false
    }
}



// MARK:- COLLECTION VIEW

extension ViewMoreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6// 수정 해야 함
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let recentProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentProjectCardCollectionViewCell.identifier, for: indexPath) as? RecentProjectCardCollectionViewCell else { return UICollectionViewCell() }
        
        return recentProjectCell
    }
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    } // 셀 좌우 간격 조정
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: recentProjectCollectionView.frame.width, height: recentProjectCollectionView.frame.height)
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 27, left: 27, bottom: 0, right: 27)
    }*/
}
