//
//  ProjectFinalViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/18.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectFinalViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var projectIndex = 0
    
    var projectInfo: FinalProjectInfo?
    var roundsInfo: [RoundInfo]?
    var scrapCardInfo: ProjectWithScrap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        let projectInfoCell = UINib(nibName: "ProjectInfoCell", bundle: nil)
        let roundInfoCell = UINib(nibName: "RoundInfoCell", bundle: nil)
        let footer = UINib(nibName: "ProjectFinishFooterView", bundle: nil)

        self.collectionView.register(projectInfoCell, forCellWithReuseIdentifier: "projectInfoCell")
        self.collectionView.register(roundInfoCell, forCellWithReuseIdentifier: "roundInfoCell")
        
        self.collectionView.register(footer, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "projectFinishFooterView")
        
        self.collectionView.collectionViewLayout = createLayout()
        
        self.setNaviTitle()
        
        print("프로젝트 인덱스 \(projectIndex)")
        NetworkManager.shared.fetchFinalProjectInfo(projectIdx: projectIndex) { (response) in
            self.projectInfo = response?.data
            
            guard self.projectInfo != nil && self.roundsInfo != nil && self.scrapCardInfo != nil else {return}
            print("reload")
            self.collectionView.reloadData()
        }
        
        NetworkManager.shared.fetchAllRoundInfo(projectIdx: projectIndex) { (response) in
            print(response)
            
            self.roundsInfo = response?.data
            
            guard self.projectInfo != nil && self.roundsInfo != nil && self.scrapCardInfo != nil else {return}
            print("reload")
            self.collectionView.reloadData()
        }
        
        NetworkManager.shared.fetchAllScrapCard(projectIdx: projectIndex) { (response) in
            self.scrapCardInfo = response?.data
            
            guard self.projectInfo != nil && self.roundsInfo != nil && self.scrapCardInfo != nil else {return}
            print("reload")
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.collectionView.reloadData()
    }
    
        func createLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout {

                (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

                if sectionIndex == 0 {

                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0)))
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(0.465)),
                    subitem: item, count: 1)

                let section = NSCollectionLayoutSection(group: group)
                    
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(33))
                    
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
                section.boundarySupplementaryItems = [sectionFooter]
                    
                return section
                } else if sectionIndex == 1 {

                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                         heightDimension: .fractionalWidth(1)))

                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32),
                                                          heightDimension: .fractionalHeight(0.1892))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

                    let spacing = CGFloat(self.view.frame.width * 0.02)

                    let section = NSCollectionLayoutSection(group: group)
                    
                    section.interGroupSpacing = spacing
                    
                    section.contentInsets = NSDirectionalEdgeInsets(top: self.view.frame.height*0.0138, leading: self.view.frame.width*0.072, bottom: self.view.frame.height*0.010, trailing: self.view.frame.width*0.072)
                    
                    section.orthogonalScrollingBehavior = .continuous
                    return section
                } else {
                    
                    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                         heightDimension: .fractionalWidth(1)))

                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                          heightDimension: .fractionalHeight(0.172)) // width = 0.86 , 0.158
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

                    let spacing = CGFloat(self.view.frame.height * 0.018)
                    
                    let section = NSCollectionLayoutSection(group: group)
                    
                    section.interGroupSpacing = spacing
                    
                    section.contentInsets = NSDirectionalEdgeInsets(top: self.view.frame.height * 0.018, leading: self.view.frame.width * 0.058, bottom: self.view.frame.height * 0.018, trailing: self.view.frame.width * 0.058)
                    
                    return section

                }

            }

            return layout
        }

}

extension ProjectFinalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
//            return self.scrapCardInfo.card_item.count
            return 10
        } else {
            print(roundsInfo)
            print(roundsInfo?.count)
            let count = self.roundsInfo?.count ?? 0
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectInfoCell", for: indexPath) as! ProjectInfoCell
            cell.projectName.text = projectInfo?.project_name
            cell.roundInfo.text = "\(projectInfo?.project_date) \n ROUND 총 \(projectInfo?.round_count)회"
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
            cell.heartBtn.isHidden = true
            cell.memo.text = "테스트 테스트 테스트 테스트"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundInfoCell", for: indexPath) as! RoundInfoCell
            cell.roundNumbLabel.text = "ROUND \(roundsInfo?[indexPath.row].round_number)"
            cell.roundGoalLabel.text = roundsInfo?[indexPath.row].round_purpose!
            cell.timeLabel.text = "총 \(roundsInfo?[indexPath.row].round_time)분 소요"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "projectFinishFooterView", for: indexPath) as! ProjectFinishFooterView
        return footer
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 33)
    }
}
