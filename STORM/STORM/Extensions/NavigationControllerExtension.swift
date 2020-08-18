//
//  NavigationBarExtension.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/08.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setNavigationBar() {
        let img = UIImage(named: "red_navigation_bar")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
               
        let titmeImg = UIImage(named: "img_logo")
        let imageView = UIImageView(image:titmeImg)
        self.navigationItem.titleView = imageView
    }
    
    func setNaviBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
               
               navigationBar.setBackgroundImage(UIImage(), for: .default)
               navigationBar.clipsToBounds = true
               navigationBar.isTranslucent = true
               navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width * (106/375))
               
               //TODO: height 계산 어떻게 하더라...
               
               guard let titleImage = UIImage(named: "imgLogo") else { return }
               let titleImageView = UIImageView(image: titleImage)
               titleImageView.contentMode = .scaleAspectFill
               self.navigationItem.titleView = titleImageView
               
               let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "roundviewBtnBack"),
                                                                      style: .plain,
                                                                      target: self,
                                                                      action: nil)
               
               let myPageButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "roundviewBtnMypage"),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: nil)
               
               navigationItem.leftBarButtonItem = backButton
               navigationItem.rightBarButtonItem = myPageButton
               backButton.tintColor = .white
               myPageButton.tintColor = .white
    }
}
