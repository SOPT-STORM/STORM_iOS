//
//  ScrapCardViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ScrapCardViewController: UIViewController {

    @IBOutlet weak var projectTitleView: UIView!
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var cardScrapCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTitleView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 1))
        projectTitleView.setRadius(radius: 10)
        cardScrapCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cardScrapCollectionView.delegate = self
        cardScrapCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

}

extension ScrapCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    
}

extension ScrapCardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: cardScrapCollectionView.frame.width * (147 / 375), height: cardScrapCollectionView.frame.height)
        } // TODO: 왜 안 되지...ㅠㅠ
    }

