//
//  ExampleViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.

import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet weak var exampleCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("뷰뜸")
        
        exampleCollectionview.delegate = self
        exampleCollectionview.dataSource = self
        
        
    }
}

extension ExampleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK:- COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let exampleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "exampleCell", for: indexPath)
        
        return exampleCell
    }
    
    
    
    
}
