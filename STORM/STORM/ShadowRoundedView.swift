//
//  ShadowRoundedView.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ShadowRoundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadowAndRound()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addShadowAndRound()
    }
    
    private func addShadowAndRound() {
        self.layer.cornerRadius = cornerRadius
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        
        layer.shadowOpacity = 0.3 // 0.16
        layer.shadowRadius = 15
        
        let containerView = UIView(frame: frame)
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(containerView, at: 0)
        
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        addSubviews(parentView: containerView)
    }
    
    private func addSubviews(parentView: UIView) {
        for i in 0..<self.subviews.count {
            if i != 0 {
                parentView.addSubview(self.subviews[i])
            }
        }
    }
    
}

