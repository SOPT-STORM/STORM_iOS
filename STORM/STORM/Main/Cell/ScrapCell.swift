//
//  ScrapCell.swift
//  STORM
//
//  Created by 김지현 on 2020/08/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ScrapCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteView: UIView!
    
    func addMemo(text: String, index: Int) {
        let label = UILabel()
        
        let width = whiteView.frame.width
        
        label.frame.size = CGSize(width: width, height: width)
        label.frame.origin = CGPoint(x: self.whiteView.frame.width * 0.0625, y: self.whiteView.frame.width * 0.0928)
        
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 12)
        label.text = text
        label.numberOfLines = 3
        self.whiteView.addSubview(label)
    }
    
    func addDrawingImg(url: URL, index: Int) {
        let imageView = UIImageView()
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.whiteView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: self.whiteView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.whiteView.topAnchor).isActive = true
        
        imageView.trailingAnchor.constraint(equalTo: self.whiteView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.whiteView.bottomAnchor).isActive = true

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
