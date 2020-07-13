//
//  CustomViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import FirebaseUI
import Lottie

class CustomViewController: FUIAuthPickerViewController {
    
    // MARK:- 변수 선언
    
    let animationView = AnimationView()
    
    // MARK:- 함수 선언
    
    func setupAnimation(){
        //animationView 크기가 view와 같게
        animationView.frame = view.bounds
        //어떤 jsonv파일을 쓸지
        animationView.animation = Animation.named("login_bg")
        //화면에 적합하게
        animationView.contentMode = .scaleAspectFit
        //반복되게
        animationView.loopMode = .loop
        //실행
        animationView.play()
        //view안에 Subview로 넣어준다
        view.insertSubview(animationView, at: 0)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, authUI: FUIAuth){
        super.init(nibName: "FUIAuthPickerViewController", bundle: nibBundleOrNil,authUI:authUI)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK:- viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        setupAnimation()
    }
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        // MARK: LAYOUT
        // MARK: LOGO
        
        let stormImageView = UIImageView(frame: CGRect(x:width/2-21, y: (height/2)*0.8, width: 42, height: 75))
        stormImageView.image = UIImage(named: "loginStormLogo")
        
        let stormImageView2 = UIImageView(frame: CGRect(x:width/2-53, y: (height/2)*1.06, width: 107, height: 24))
               stormImageView2.image = UIImage(named: "stormTextLogo")
        
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
        loginButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -(height*0.25)).isActive = true // 이거 설정 어케해줘야 할지 모르겠음 ㅠㅅㅠ
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK:- KAKAO LOGIN BUTTON
    
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
}
