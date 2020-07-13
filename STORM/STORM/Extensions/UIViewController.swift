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
        toastMessage.setRound(5)
        toastMessage.addShadow(width: 1, height: 1, 0.16, 3)
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
        

        
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor.white
//        toastLabel.font = font
//        toastLabel.textAlignment = .center;
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        self.view.addSubview(toastLabel)
//        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
//             toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    } }
}
