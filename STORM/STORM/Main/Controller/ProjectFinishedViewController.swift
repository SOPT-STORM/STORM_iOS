//
//  ProjectFinishedViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectFinishedViewController: UIViewController {
    
    // MARK:- 변수 선언
    
    private var textList: [String]?
    private var imageList: [UIImage]?
    
    var projectIndex = 1
    var roundIndex = 1
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var roundCollectionView: UICollectionView!

    /*
    @IBAction func sliderAction(_ sender: UISlider) {
        self.scrappedCardCollectionView.contentOffset.x += CGFloat(sender.value)
    }
    */
    
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: HEADER
//       roundCollectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")
        
        // MARK: 네비게이션 바 색, 로고
        //self.setNaviTitle()
        
        
        // MARK: Nib register (RoundCollectionView)
        
        roundCollectionView.register(UINib(nibName: "RoundCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: RoundCollectionViewCell.identifier)
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        //roundCollectionView.clipsToBounds = true

        //roundCollectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")
        
        fetchfinalProjectInfo()
    }
    
    // MARK:- func

    func fetchfinalProjectInfo() {
        NetworkManager.shared.fetchFinalProjectInfo(projectIdx: self.projectIndex ) {
        (response) in
            //headerView.projectDateLabel.text = response?.data.project_date
            //headerView.projectRoundNumLabel.text = "Round 총 \(response?.data.round_count ?? 0)회"
        }
    }
}

// MARK:- COLLECTION VIEW

extension ProjectFinishedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let roundCell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as? RoundCollectionViewCell else { return UICollectionViewCell()
        }
        return roundCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.2933
        return CGSize(width: width, height: width * 1.0909)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       let rlInset = self.view.frame.width * 0.08
       let tbInset = self.view.frame.width * 0.0213
        
        return UIEdgeInsets(top: 1.5, left: rlInset, bottom: 1.5, right: rlInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.034
    }
    
    // MARK:- REUSABLE VIEW
       
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

                   switch kind {
                   case UICollectionView.elementKindSectionHeader:
                    let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionHeader", for: indexPath) as! CollectionHeader

        //               reusableView.projectInfoView.addShadow(width: 1, height: 4, 0.3, 3)

                       // MARK: COLLECTION VIEW SCRAP

                       reusableView.scrappedCollectionView.delegate = self
                       reusableView.scrappedCollectionView.dataSource = self

                       return reusableView
                   default:
                       assert(false, "")
                   }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionHeader", for: indexPath) as! CollectionHeader
            
            return headerView
    }
        

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           let width: CGFloat = collectionView.frame.width
           let height: CGFloat = width * 1.392
           return CGSize(width: width, height: height)
    }
}
