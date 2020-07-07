//
//  CollecViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/05.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollecViewController: UIViewController {
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .blue
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var isfirstTimeTransform:Bool = true
    
}

extension CollecViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
//    }
//
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .red
//        cell.layer.cornerRadius = 12
//        return cell
//    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let pageWidth: Float = Float(self.collectionView.frame.width / 3) //480 + 50
//        // width + space
//        let currentOffset: Float = Float(scrollView.contentOffset.x)
//        let targetOffset: Float = Float(targetContentOffset.pointee.x)
//        var newTargetOffset: Float = 0
//        if targetOffset > currentOffset {
//            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
//        }
//        else {
//            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
//        }
//        if newTargetOffset < 0 {
//            newTargetOffset = 0
//        }
//        else if (newTargetOffset > Float(scrollView.contentSize.width)){
//            newTargetOffset = Float(Float(scrollView.contentSize.width))
//        }
//
//        targetContentOffset.pointee.x = CGFloat(currentOffset)
//        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
//
//    }
    
    //
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .red
                cell.layer.cornerRadius = 12
              

        if (indexPath.row == 0 && isfirstTimeTransform) {
            isfirstTimeTransform = false
        }else{
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        // Simulate "Page" Function
//        let pageWidth: Float = Float(self.collectionView.frame.width/3 + 20)
//        let currentOffset: Float = Float(scrollView.contentOffset.x)
//        let targetOffset: Float = Float(targetContentOffset.pointee.x)
//        var newTargetOffset: Float = 0
//        if targetOffset > currentOffset {
//            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
//        }
//        else {
//            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
//        }
//        if newTargetOffset < 0 {
//            newTargetOffset = 0
//        }
//        else if (newTargetOffset > Float(scrollView.contentSize.width)){
//            newTargetOffset = Float(Float(scrollView.contentSize.width))
//        }
//
//        targetContentOffset.pointee.x = CGFloat(currentOffset)
//        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
//
//        // Make Transition Effects for cells
//        let duration = 0.2
//        var index = newTargetOffset / pageWidth;
//        var cell:UICollectionViewCell = self.collectionView.cellForItem(at: IndexPath(row: Int(index), section: 0))!
//        if (index == 0) { // If first index
//            UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
//                cell.transform = CGAffineTransform.identity
//            }, completion: nil)
//            index += 1
//            cell = self.collectionView.cellForItem(at: IndexPath(row: Int(index), section: 0))!
//            UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
//                cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            }, completion: nil)
//        }else{
//            UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
//                cell.transform = CGAffineTransform.identity;
//            }, completion: nil)
//
//            index -= 1 // left
//            if let cell = self.collectionView.cellForItem(at: IndexPath(row: Int(index), section: 0)) {
//                UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
//                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
//                }, completion: nil)
//            }
//
//            index += 1
//            index += 1 // right
//            if let cell = self.collectionView.cellForItem(at: IndexPath(row: Int(index), section: 0)) {
//                UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
//                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
//                }, completion: nil)
//            }
//        }
//
//    }
    
    
}

class customCell: UICollectionViewCell {
    
//    fileprivate let bg: UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.layer.cornerRadius = 12
//        return iv
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(bg)
//        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        bg.bottomAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
