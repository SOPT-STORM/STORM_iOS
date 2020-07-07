//
//  CustomViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import FirebaseUI

class CustomViewController: FUIAuthPickerViewController {


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, authUI: FUIAuth){
        super.init(nibName: "FUIAuthPickerViewController", bundle: nibBundleOrNil,authUI:authUI)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        // MARK: LAYOUT
        // MARK: GOOGLE
        
        let stormImageView = UIImageView(frame: CGRect(x:width/2-47, y: height/2-94, width: 94, height: 94))
        stormImageView.image = UIImage(named: "kakaoTalkPhoto20200702143023")
        
        let stormImageView2 = UIImageView(frame: CGRect(x:width/2-53, y: height/2+49, width: 107, height: 24))
               stormImageView2.image = UIImage(named: "asset13X8")
        
        self.view.insertSubview(stormImageView, at: self.view.subviews.count)
        self.view.insertSubview(stormImageView2, at: self.view.subviews.count)
        
        self.view.subviews[0].backgroundColor = UIColor.clear
        self.view.subviews[0].subviews[0].backgroundColor = UIColor.clear
        
        // MARK: LAYOUT
        // MARK: KAKAO
        
        let guide = view.safeAreaLayoutGuide
        view.addSubview(loginButton)
        
        loginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 75).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -75).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -180).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private let loginButton: KOLoginButton = {
      let button = KOLoginButton()
      button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
    
    @objc private func touchUpLoginButton(_ sender: UIButton) {
      guard let session = KOSession.shared() else {
        return
      }
      
      if session.isOpen() {
        session.close()
      }
      
      session.open { (error) in
        if error != nil || !session.isOpen() { return }
        KOSessionTask.userMeTask(completion: { (error, user) in
          guard let user = user,
                let email = user.account?.email,
                let nickname = user.nickname else { return }
          
         
        })
      }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
