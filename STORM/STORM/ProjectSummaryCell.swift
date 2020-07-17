//
//  ProjectSummaryCell.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/16.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Kingfisher

class ProjectSummaryCell: UICollectionViewCell {
    
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var gridView: UIView!
   
    @IBOutlet weak var columnBoundary: UIView!
    @IBOutlet weak var rowBoundary: UIView!
    
    func addMemo(text: String, index: Int) {
        let width = self.gridView.frame.width * 0.3672
        let label = UILabel()
        label.frame.size = CGSize(width: width, height: width)
        
        switch index{
        case 0:
            label.frame.origin = CGPoint(x: self.gridView.frame.width * 0.0625, y: self.gridView.frame.width * 0.0928)
        case 1:
            label.frame.origin = CGPoint(x: self.gridView.frame.width * 0.57, y: self.gridView.frame.width * 0.0928)
        case 2:
            label.frame.origin = CGPoint(x: self.gridView.frame.width * 0.0625, y: self.gridView.frame.width * 0.585)
        case 3:
            label.frame.origin = CGPoint(x: self.gridView.frame.width * 0.57, y: self.gridView.frame.width * 0.585)
        default:
            break
        }
        
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 10)
        label.text = text
        label.numberOfLines = 0
        self.gridView.addSubview(label)
    }
    
    func addDrawingImg(url: URL, index: Int) {
        let imageView = UIImageView()
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.gridView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        print("이미지 뷰~~ \(imageView)")
        print("칼럼 바운더리~~ \(self.columnBoundary)")
        switch index{
            case 0:
                imageView.leadingAnchor.constraint(equalTo: self.gridView.leadingAnchor).isActive = true
                imageView.topAnchor.constraint(equalTo: self.gridView.topAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: self.columnBoundary.leadingAnchor).isActive = true
                imageView.bottomAnchor.constraint(equalTo: self.rowBoundary.topAnchor).isActive = true
            case 1:
                imageView.leadingAnchor.constraint(equalTo: self.columnBoundary.trailingAnchor).isActive = true
                imageView.topAnchor.constraint(equalTo: self.gridView.topAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: self.gridView.trailingAnchor).isActive = true
                imageView.bottomAnchor.constraint(equalTo: self.rowBoundary.topAnchor).isActive = true
            case 2:
                imageView.leadingAnchor.constraint(equalTo: self.gridView.leadingAnchor).isActive = true
                imageView.topAnchor.constraint(equalTo: self.rowBoundary.bottomAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: self.columnBoundary.leadingAnchor).isActive = true
                imageView.bottomAnchor.constraint(equalTo: self.gridView.bottomAnchor).isActive = true
            case 3:
                imageView.leadingAnchor.constraint(equalTo: self.columnBoundary.trailingAnchor).isActive = true
                imageView.topAnchor.constraint(equalTo: self.rowBoundary.bottomAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: self.gridView.trailingAnchor).isActive = true
                imageView.bottomAnchor.constraint(equalTo: self.gridView.bottomAnchor).isActive = true
            default:
                break
        }
    }
}


