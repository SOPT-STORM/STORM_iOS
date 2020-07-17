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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.2
        return CGSize(width: width, height: width * 1.075)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let inset = self.view.frame.width * 0.072
       return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.072
    }
}
