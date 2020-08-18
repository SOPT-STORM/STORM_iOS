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
        
        let toastMessage = UIView(frame: frame)
        toastMessage.center.x = frame.origin.x
        
//        toastMessage.layer.cornerRadius = 10
//        toastMessage.layer.backgroundColor = UIColor.clear.cgColor
//        toastMessage.layer.shadowColor = UIColor.black.cgColor
//        toastMessage.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        toastMessage.layer.shadowOpacity = 0.16 // 0.16
//        toastMessage.layer.shadowRadius = 5
        
        let content = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        content.backgroundColor = .white
        content.font = UIFont(name: "NotoSansCJKkr-Medium", size: 11)
        content.textColor = UIColor(red: 142/256, green: 142/256, blue: 142/256, alpha: 1)
        content.textAlignment = .center
        content.text = message
        
//        content.layer.cornerRadius = 10
//        content.layer.masksToBounds = true
        
        
        toastMessage.addSubview(content)
        toastMessage.addRoundShadow(contentView: content, cornerRadius: 10)

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
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .white
        
        let titmeImg = UIImage(named: "img_logo")
        let imageView = UIImageView(image:titmeImg)
        navigationItem.titleView = imageView
    }
    
//    @objc func didPressMyPage() {
//        print("마이페이지~")
//    }
}
