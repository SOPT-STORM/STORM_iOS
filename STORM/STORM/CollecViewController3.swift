//
//  CollecViewController3.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/05.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollecViewController3: UIViewController {

    @IBOutlet weak var testCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testCollectionView.delegate = self
        testCollectionView.dataSource = self
        testCollectionView.register(UINib(nibName: "TestCell", bundle: nil), forCellWithReuseIdentifier: "testCell")
        

        // Do any additional setup after loading the view.
    }


}

extension CollecViewController3: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! TestCell
        
        return cell
    }
    
    
}
