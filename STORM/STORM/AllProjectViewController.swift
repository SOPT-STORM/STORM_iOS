//
//  AllProjectViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class AllProjectViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var data: [ProjectWithDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.setNaviTitle()

        collectionView.reloadData()
    }
}

extension AllProjectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var idx = 0

        let data = self.data[indexPath.row]

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
        
        let width = self.view.frame.width * 0.392
        return CGSize(width: width, height: width * 1.306)
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

