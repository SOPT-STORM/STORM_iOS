//
//  ScrapCardViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class ScrapCardViewController: UIViewController {

    @IBOutlet weak var projectTitleView: UIView!
    @IBOutlet weak var cardCountLabel: UILabel!
//    @IBOutlet weak var cardScrapCollectionView: UICollectionView!
    
    @IBOutlet weak var cardScrapCollectionView: UICollectionView!
    

    var cards = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardScrapCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cardScrapCollectionView.delegate = self
        cardScrapCollectionView.dataSource = self
        let aligned = cardScrapCollectionView.collectionViewLayout as? AlignedCollectionViewFlowLayout
        aligned?.horizontalAlignment = .left

        // Do any additional setup after loading the view.
    }
    

}

extension ScrapCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        cell.isScrap = false
        cell.didScrap = {

            UIView.animate(withDuration: 0.5, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    cell.alpha = 0.0;
                    }, completion:{(finished : Bool)  in
                        if (finished)
                        {
                            // cell.removeFromSuperview()
                            self.cards -= 1
                            self.cardScrapCollectionView.reloadData()
                            self.cardCountLabel.text = "총 \(self.cards)개의 카드"
                        }
                });
            

        }
        return cell
    }
    
    
}

extension ScrapCardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: cardScrapCollectionView.frame.width, height: cardScrapCollectionView.frame.height)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

            return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 28, left: 27, bottom: 0, right: 27)
    }

}

