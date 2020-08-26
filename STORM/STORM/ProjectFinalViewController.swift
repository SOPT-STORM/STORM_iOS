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
        
        
        if self.presentingViewController != nil && !(self.presentingViewController is LogInViewController) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(didPressExit))
            guard let projectIndex = ProjectSetting.shared.projectIdx else {return}
            self.projectIndex = projectIndex
        }
        
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
            
            print(response)
            
            self.projectInfo = response?.data
            
            guard self.projectInfo != nil && self.roundsInfo != nil && self.scrapCardInfo != nil else {return}
            self.collectionView.reloadData()
        }
        
        NetworkManager.shared.fetchAllRoundInfo(projectIdx: projectIndex) { (response) in
            self.roundsInfo = response?.data
            
            print(response)
            
            guard self.projectInfo != nil && self.roundsInfo != nil && self.scrapCardInfo != nil else {return}
            
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.fetchAllScrapCard(projectIdx: projectIndex) { (response) in
            self.scrapCardInfo = response?.data
            
            print(response)
            
            guard self.projectInfo != nil && self.roundsInfo != nil && self.scrapCardInfo != nil else {return}
            
            self.collectionView.reloadData()
        }
    }
    
    @objc func didPressExit() {
        let rootVC = self.view.window?.rootViewController
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            guard let navi = rootVC as? UINavigationController else {return}
            navi.popToRootViewController(animated: false)
        })
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
            return self.scrapCardInfo?.card_item.count != nil ? scrapCardInfo!.card_item.count : 0
        } else {
            return self.roundsInfo?.count != nil ? roundsInfo!.count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectInfoCell", for: indexPath) as! ProjectInfoCell
            
            guard let projectInformation = projectInfo else {return cell}
 
            cell.participants = projectInformation.project_participants_list
            cell.projectName.text = projectInformation.project_name
            cell.roundInfo.text = "\(projectInformation.project_date) \n ROUND 총 \(projectInformation.round_count)회"
            return cell
        } else if indexPath.section == 1 {
            
            guard let scrapCardInfo = scrapCardInfo?.card_item[indexPath.row] else {return UICollectionViewCell()}
            
            if scrapCardInfo.card_img != nil {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! DrawingCell
                cell.heartBtn.isHidden = true
                
                guard let url = scrapCardInfo.card_img,let imageURL = URL(string: url) else {return UICollectionViewCell()}
                
                cell.drawingImgView.kf.setImage(with: imageURL)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCell", for: indexPath) as! MemoCell
                cell.heartBtn.isHidden = true
                cell.memo.text = scrapCardInfo.card_txt!
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundInfoCell", for: indexPath) as! RoundInfoCell
            
            guard let roundInfo = roundsInfo?[indexPath.row], let roundNumber = roundInfo.round_number, let roundPurpose = roundInfo.round_purpose, let roundTime = roundInfo.round_time else {return cell}
            
            cell.roundNumbLabel.text = "ROUND \(roundNumber)"
            cell.roundGoalLabel.text = roundPurpose
            cell.timeLabel.text = "총 \(roundTime)분 소요"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "projectFinishFooterView", for: indexPath) as! ProjectFinishFooterView
        
        footer.delegate = self
        return footer
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 33)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            guard let vc = UIStoryboard(name: "RoundFinished", bundle: nil).instantiateViewController(withIdentifier: "finishedRoundViewController") as? FinishedRoundViewController else {return}
            
            guard let roundInformation = roundsInfo, let roundIdx = roundInformation[indexPath.row].round_idx else {return}
            
            vc.roundsInfo = roundInformation
            vc.selectedIndex = indexPath.row
            vc.projectIndex = projectIndex
            vc.projectName = projectInfo!.project_name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProjectFinalViewController: PushVC {
    func pushVC() {
        
        let storyboard = UIStoryboard(name: "RoundFinished", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "scrapCardViewController") as? ScrapCardViewController else {return}
        
        guard let projectInformation = projectInfo, let cards = scrapCardInfo?.card_item else {return}
        
        vc.projectName = projectInformation.project_name
        vc.scrappedCards = cards
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

