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
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var gridView: UIView!
    
    @IBOutlet weak var columnBoundary: UIView!
    @IBOutlet weak var rowBoundary: UIView!
    
    override func prepareForReuse() {
        self.gridView.subviews.forEach({
            if ($0 is UILabel || $0 is UIImageView) {
                $0.removeFromSuperview()
            }
        })
    }
    
    override func layoutSubviews() {
        shadowView.addRoundShadow(contentView: gridView, cornerRadius: 15)
    }
    
    func addMemo(text: String, index: Int) {
        
        let label = UILabel()
        
        self.gridView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let topAndBotConst = self.gridView.frame.height * 0.0694
        let leadAndTrailConst = self.gridView.frame.width * 0.0544
        
        switch index{
        case 0:
            
            label.leadingAnchor.constraint(equalTo: self.gridView.leadingAnchor, constant: leadAndTrailConst).isActive = true
            label.topAnchor.constraint(equalTo: self.gridView.topAnchor, constant: topAndBotConst).isActive = true
            label.trailingAnchor.constraint(equalTo: self.columnBoundary.leadingAnchor, constant: -leadAndTrailConst).isActive = true
            label.bottomAnchor.constraint(equalTo: self.rowBoundary.topAnchor, constant: -topAndBotConst).isActive = true
            
        case 1:
            
            label.leadingAnchor.constraint(equalTo: self.columnBoundary.trailingAnchor, constant: leadAndTrailConst).isActive = true
            label.topAnchor.constraint(equalTo: self.gridView.topAnchor, constant: topAndBotConst).isActive = true
            label.trailingAnchor.constraint(equalTo: self.gridView.trailingAnchor, constant: -leadAndTrailConst).isActive = true
            label.bottomAnchor.constraint(equalTo: self.rowBoundary.topAnchor, constant: -topAndBotConst).isActive = true
            
        case 2:
            label.leadingAnchor.constraint(equalTo: self.gridView.leadingAnchor, constant: leadAndTrailConst).isActive = true
            label.topAnchor.constraint(equalTo: self.rowBoundary.bottomAnchor, constant: topAndBotConst).isActive = true
            label.trailingAnchor.constraint(equalTo: self.columnBoundary.leadingAnchor, constant: -leadAndTrailConst).isActive = true
            label.bottomAnchor.constraint(equalTo: self.gridView.bottomAnchor, constant: -topAndBotConst).isActive = true
            
        case 3:
            label.leadingAnchor.constraint(equalTo: self.columnBoundary.trailingAnchor, constant: leadAndTrailConst).isActive = true
            label.topAnchor.constraint(equalTo: self.rowBoundary.bottomAnchor, constant: topAndBotConst).isActive = true
            label.trailingAnchor.constraint(equalTo: self.gridView.trailingAnchor, constant: -leadAndTrailConst).isActive = true
            label.bottomAnchor.constraint(equalTo: self.gridView.bottomAnchor, constant: -topAndBotConst).isActive = true
            
        default:
            break
        }
        
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 11)
        label.text = text
        label.numberOfLines = 0
        label.textColor = UIColor(red: 78/255, green: 78/255, blue: 78/255, alpha: 1)
    }
    
    func addDrawingImg(url: URL, index: Int) {
        let imageView = UIImageView()
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.gridView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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


