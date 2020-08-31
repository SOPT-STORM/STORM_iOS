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

    @IBOutlet weak var projectNameLabel: UILabel!
    
    @IBOutlet weak var cardScrapCollectionView: UICollectionView!
    
    lazy var projectName = ""
    //lazy var scrappedCards: [scrappedCard] = []
    lazy var scrappedCards: [CardItem] = []
    lazy var projectIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameLabel.text = projectName
        cardCountLabel.text = "총 \(scrappedCards.count)개의 카드"

        cardScrapCollectionView.delegate = self
        cardScrapCollectionView.dataSource = self
        
        self.setNaviTitle()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(back))
    }

    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.fetchAllScrapCard(projectIdx: projectIndex) { (response) in
            guard let scrapCards = response?.data?.card_item else {return}
            
            self.scrappedCards = scrapCards

            self.cardScrapCollectionView.reloadData()
        }
    }
}


extension ScrapCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrappedCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = scrappedCards[indexPath.row]
        ProjectSetting.shared.scrapCards[indexPath.row] = true
    
        if card.card_img != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
            
            guard let url = card.card_img,let imageURL = URL(string: url) else {return UICollectionViewCell()}
            
            cell.drawingImgView.kf.setImage(with: imageURL)
            cell.cardIndex = card.card_idx
            
            cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.heartBtn.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
            cell.isScrapped = true
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
 
            cell.memo.text = card.card_txt!
            cell.cardIndex = card.card_idx
            
            cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.heartBtn.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
            cell.isScrapped = true
            
            return cell
        }
    }
    
    
}

extension ScrapCardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.392
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "RoundFinished", bundle: nil).instantiateViewController(withIdentifier: "cardDetailViewController") as? CardDetailViewController else {return}
        
        vc.scrappedCards = scrappedCards
        vc.index = indexPath.row
        vc.viewMode = .scrap
        vc.projectName = projectName

        self.navigationController?.pushViewController(vc, animated: true)
    }
}



