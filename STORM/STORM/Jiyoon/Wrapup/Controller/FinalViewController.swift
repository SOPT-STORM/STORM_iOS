//
//  FinalViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController, UICollectionViewDelegate {


    @IBOutlet weak var roundCollectionView: UICollectionView!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - IBAction
    
    @IBAction func myPageButtonDidPress(_ sender: UIBarButtonItem) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCollectionView.register(UINib(nibName: "RoundCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RoundCollectionViewCell.identifier)
        roundCollectionView.layer.cornerRadius = 15
        roundCollectionView.layer.masksToBounds = true
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        cardListCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cardListCollectionView.delegate = self
        cardListCollectionView.dataSource = self
        setNavigationBar()

    }

    func setNavigationBar() {
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.clipsToBounds = true
        navigationBar.isTranslucent = true
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width * (106/375))
        
        //TODO: height 계산 어떻게 하더라...
        
        guard let titleImage = UIImage(named: "imgLogo") else { return }
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = titleImageView
        
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "roundviewBtnBack"),
                                                               style: .plain,
                                                               target: self,
                                                               action: nil)
        
        let myPageButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "roundviewBtnMypage"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = myPageButton
        backButton.tintColor = .white
        myPageButton.tintColor = .white
    }

}


extension FinalViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
        return 5
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as! RoundCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
            return cell
        }
        
    }
    
}

extension FinalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            let width = roundCollectionView.bounds.width
            let height = width * (115 / 375)
                   
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: cardListCollectionView.frame.width, height: cardListCollectionView.frame.height)
        } // TODO: 왜 안 되지...ㅠㅠ
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 0 {
            return 0
        } else {
            return 28
        }
}

}
