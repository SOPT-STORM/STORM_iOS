//
//  UIViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Lottie

extension UIViewController {
    
    func showToast(message : String, frame: CGRect) {
        
        let toastMessage = UIView(frame: frame)
        toastMessage.center.x = frame.origin.x
        toastMessage.backgroundColor = .purple
        
        let content = UILabel(frame: CGRect(x: 0, y: 0, width: round(frame.width), height: round(frame.height)))
        content.backgroundColor = .white
        content.font = UIFont(name: "NotoSansCJKkr-Medium", size: 11)
        content.textColor = UIColor(red: 142/256, green: 142/256, blue: 142/256, alpha: 1)
        content.textAlignment = .center
        content.text = message
        
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
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .white
        
//        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "13" ), style: .plain, target: self, action: #selector(back))
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        let titmeImg = UIImage(named: "img_logo")
        let imageView = UIImageView(image:titmeImg)
        navigationItem.titleView = imageView
    }
    
    func loadSplashView() {

        if ApplicationSetting.shared.isFirstEnter == true {
            let animationView = AnimationView()
        
            animationView.frame = UIScreen.main.bounds //UIScreen.main.bounds
        
            animationView.animation = Animation.named("splash")
        
            animationView.contentMode = .scaleAspectFit
        
            animationView.play()
        
            self.navigationController?.view.addSubview(animationView)
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                animationView.removeFromSuperview()
                ApplicationSetting.shared.isFirstEnter = false
            }
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setSignUpNavi() {
        // 수정 필요 ㅠㅜ
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "회원가입"
        navigationController?.navigationBar.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
    }
}
