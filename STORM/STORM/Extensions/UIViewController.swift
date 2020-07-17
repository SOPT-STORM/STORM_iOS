//
//  UIViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String, frame: CGRect) {
        
//        let view = UIView(frame: frame)
//        view.setRound(5)
//        view.addShadow(width: 1, height: 1, 0.5, 3)
//        view.backgroundColor = .white
        
        let toastMessage = UILabel(frame: frame)
        toastMessage.center.x = frame.origin.x
//        toastMessage.setRound(5)
//        toastMessage.addShadow(width: 1, height: 1, 0.16, 3)
        toastMessage.addRoundShadow(cornerRadius: 5)
        toastMessage.backgroundColor = .white
        toastMessage.font = UIFont(name: "NotoSansCJKkr-Medium", size: 11)
        toastMessage.textColor = UIColor(red: 142/256, green: 142/256, blue: 142/256, alpha: 1)
        toastMessage.textAlignment = .center
        toastMessage.text = message
//        toastMessage.clipsToBounds = true
        
//        view.addSubview(toastMessage)
        
        self.view.addSubview(toastMessage)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastMessage.alpha = 0.0
        }, completion: {(isCompleted) in
            toastMessage.removeFromSuperview()
        })
    }
    
    func setNaviTitle() {
        let img = UIImage(named: "red_navigation_bar")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let titmeImg = UIImage(named: "img_logo")
        let imageView = UIImageView(image:titmeImg)
        navigationItem.titleView = imageView
    }
}
