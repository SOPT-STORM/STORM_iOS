//
//  ViewMoreViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/10.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ViewMoreViewController: UIViewController {

    @IBOutlet weak var participatedProjectCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: NAVIGATION BAR
        
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem()
        //backButton.image = UIImage(named: "imageName") //Replaces title
        backButton.setBackgroundImage(UIImage(named: "seemoreCard1BtnBack"), for: .normal, barMetrics: .default) // Stretches image
        navigationItem.setLeftBarButton(backButton, animated: false)
        
        let titmeImg = UIImage(named: "imgLogo")
        let imageView = UIImageView(image:titmeImg)
        self.navigationItem.titleView = imageView
        
        participatedProjectCollectionView.delegate = self
        participatedProjectCollectionView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewMoreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let participatedProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipatedProjectCell.identifier, for: indexPath) as? ParticipatedProjectCell else { return UICollectionViewCell() }
        //participatedProjectCell.set(projectList[indexPath.row])
        return participatedProjectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    } // 셀 좌우 간격 조정
}
