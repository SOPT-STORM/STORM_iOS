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
//    @IBOutlet weak var cardScrapCollectionView: UICollectionView!
    
    @IBOutlet weak var cardScrapCollectionView: UICollectionView!
    

    var cards = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cardScrapCollectionView.collectionViewLayout = CenterAlignedCollectionViewFlowLayout()
        cardScrapCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cardScrapCollectionView.delegate = self
        cardScrapCollectionView.dataSource = self
        


        // Do any additional setup after loading the view.
    }
    

}

extension ScrapCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        cell.isScrap = false
        cell.didScrap = {

            UIView.animate(withDuration: 0.5, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    cell.alpha = 0.0;
                    }, completion:{(finished : Bool)  in
                        if (finished)
                        {
                            // cell.removeFromSuperview()
                            self.cards -= 1
                            self.cardScrapCollectionView.deleteItems(at: [IndexPath(row: 0, section: 0)])
//                            self.cardScrapCollectionView.reloadData()
                            if self.cards == 1 {
                                
                                guard let cell = collectionView.visibleCells.first else { return }
                                cell.translatesAutoresizingMaskIntoConstraints = false
                                NSLayoutConstraint.activate([
                                    cell.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 27),
                                    cell.widthAnchor.constraint(equalToConstant: 147),
                                    cell.heightAnchor.constraint(equalToConstant: 158),
                                    cell.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 27)
                                ])
                                
                                self.view.layoutIfNeeded()
                                
//                                 lastCell.translatesAutoresizingMaskIntoConstraints = false
//                                NSLayoutConstraint.activate([
//                                    lastCell.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 27)
//                                ])
                                self.view.layoutIfNeeded()
                            }
                            self.cardCountLabel.text = "총 \(self.cards)개의 카드"
                        }
                });
            

        }
        return cell
    }
    
    
}

extension ScrapCardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (cardScrapCollectionView.frame.width-27*3)/2
        let height = width * (147/158)
        return CGSize(width: width, height: height)
        }
    
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

            return 27
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        27
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 27, left: 27, bottom: 0, right: 27)
    }

}

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        // Copy each item to prevent "UICollectionViewFlowLayout has cached frame mismatch" warning
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }

        // Constants
        let leftPadding: CGFloat = 27
        let interItemSpacing: CGFloat = 27
//        let interItemSpacing = minimumInteritemSpacing - 3
        
        // Tracking values
        var leftMargin: CGFloat = leftPadding // Modified to determine origin.x for each item
        var maxY: CGFloat = -1.0 // Modified to determine origin.y for each item
        var rowSizes: [[CGFloat]] = [] // Tracks the starting and ending x-values for the first and last item in the row
        var currentRow: Int = 0 // Tracks the current row
        attributes.forEach { layoutAttribute in
            let width = (collectionView!.frame.width - 27*3) / 2
            let height = width * (147/159)
            layoutAttribute.frame = CGRect(x: layoutAttribute.frame.origin.x, y: layoutAttribute.frame.origin.y, width: width, height: height)
            // Each layoutAttribute represents its own item
            if layoutAttribute.frame.origin.y >= maxY {

                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding

                // Register its origin.x in rowSizes for use later
//                if rowSizes.count == 0 {
//                    // Add to first row
//                    rowSizes = [[leftMargin, 0]]
//                } else {
//                    // Append a new row
//                    rowSizes.append([leftMargin, 0])
//                    currentRow += 1
////                    print("currentRow: \(currentRow)")
//                }
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)

            // Add right-most x value for last item in the row
//            rowSizes[currentRow][1] = leftMargin - interItemSpacing
        }
        return attributes
    }
}
