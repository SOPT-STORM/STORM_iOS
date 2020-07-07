//
//  CollecViewController4.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollecViewController4: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    fileprivate var colors: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.yellow,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCollectionView()

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex:CGFloat = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
        
//           pageControl.currentPage = Int(currentIndex)
    }
    
    func addCollectionView(){

            // This is just an utility custom class to calculate screen points
            // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        
//            let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)

            // This is where the magic is done. With the flow layout the views are set to make costum movements. See https://github.com/ink-spot/UPCarouselFlowLayout for more info
            
        let layout = UPCarouselFlowLayout()
        
            // This is used for setting the cell size (size of each view in this case)
            // Here I'm writting 400 points of height and the 73.33% of the height view frame in points.
//        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.63333), height: collectionView.frame.size.height) // 0.73333
        
        layout.itemSize = CGSize(width: collectionView.frame.size.width*0.811, height: collectionView.frame.size.height) // 0.73333
        
            // Setting the scroll direction
        
            layout.scrollDirection = .horizontal
        
            layout.sideItemScale = 0.757//0.757
            layout.sideItemAlpha = 0.5
        

            // Collection view initialization, the collectionView must be
            // initialized with a layout object.
        
//            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
            collectionView.collectionViewLayout = layout
        
            // This line if for able programmatic constrains.
            self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
            // CollectionView delegates and dataSource:
            self.collectionView?.delegate = self
            self.collectionView?.dataSource = self
            // Registering the class for the collection view cells
            self.collectionView?.register(CardCell.self, forCellWithReuseIdentifier: "cellId")

            // Spacing between cells:
            let spacingLayout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        
//            spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: -50)
            
            spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: -170)

            self.collectionView?.backgroundColor = UIColor.gray
            self.view.addSubview(self.collectionView!)

        }

}

extension CollecViewController4: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CardCell

        cell.customView.backgroundColor = colors[indexPath.row]
        return cell
    }
}

//class CardCell: UICollectionViewCell {
//    
//    let customView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 12
//        return view
//    }()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addSubview(self.customView)
//
//        self.customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        self.customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        self.customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
//        self.customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

//class RelativeLayoutUtilityClass {
//
//    var heightFrame: CGFloat?
//    var widthFrame: CGFloat?
//
//    init(referenceFrameSize: CGSize){
//        heightFrame = referenceFrameSize.height
//        widthFrame = referenceFrameSize.width
//    }
//
//    func relativeHeight(multiplier: CGFloat) -> CGFloat{
//
//        return multiplier * self.heightFrame!
//    }
//
//    func relativeWidth(multiplier: CGFloat) -> CGFloat{
//        return multiplier * self.widthFrame!
//
//    }
//}
