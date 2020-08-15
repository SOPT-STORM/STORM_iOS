//
//  ProjectSummaryViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ProjectSummaryViewController: UIViewController {
    
    //MARK:-IBOutlet
    
    @IBOutlet weak var roundCollectionView: UICollectionView!
    var scrapCollectionView: UICollectionView!

    //MARK:-viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // make scrapcollectionview programatically
        
        //collectionview delgate & tag
        roundCollectionView.delegate = self
        roundCollectionView.dataSource = self
        //scrapCollectionView.delegate = self
        //scrapCollectionView.dataSource = self
        
        roundCollectionView.tag = 1
        //scrapCollectionView.tag = 2
    }

}

extension ProjectSummaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
            case 1 :
                return 10 //scrapData.count
        default:
            return 10 //roundData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
            case 1 :
                let scrapCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrapCell", for: indexPath) as! ScrapCell
                scrapCell.addRoundShadow(cornerRadius: 10)

                return scrapCell
        default:
            let roundCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCardCell", for: indexPath) as! RoundCardCell
                roundCell.addRoundShadow(cornerRadius: 10)
                return roundCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeader", for: indexPath) as? CollectionHeader else { fatalError("Invalid view type")}
            
            let view = UIView()
            view.backgroundColor = .white
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: 110, height: 120)
            
            scrapCollectionView = UICollectionView(frame: CGRect(x: 0, y: 300, width: 375, height: 140), collectionViewLayout: layout)
            scrapCollectionView?.register(ScrapCell.self, forCellWithReuseIdentifier: "ScrapCell")
            scrapCollectionView?.backgroundColor = UIColor.stormRed
            headerView.addSubview(scrapCollectionView ?? UICollectionView())
            
            // scrapcollectionview 옵셔널 바인딩 해야한다고 하는데 이게 무슨 말임 ㅜㅅㅜ
            // scrapcollectionview 뜨도록 하는 것을 목표로 잡자
            
            self.view = view
            
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    
}
