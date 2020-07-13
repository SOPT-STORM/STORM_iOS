//
//  ViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/06/30.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var testCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testCollection.collectionViewLayout = CollectionViewGridLayout(numberofColumns: 3)
    
    
        testCollection.backgroundColor = .blue
        
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 140)
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//        let size:CGFloat = (testCollection.frame.size.width - space) / 2.0
//        return CGSize(width: size, height: size)
//    }
    
    
}
