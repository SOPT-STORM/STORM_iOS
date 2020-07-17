//
//  RoundStartPopViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/11.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Lottie

class RoundStartPopViewController: UIViewController {
    
    static let identifier = "RoundStartPopViewController"
    
    // MARK:- 변수 선언
    
    let animationView = AnimationView()
    
    // MARK:- IBOutlet 선언
    
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var startPopView: UIView!
    
    // MARK:- viewDidLoad 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startPopView.layer.cornerRadius = 15
//        startPopView.addShadow(width: 1, height: 3, 0.2, 5)
        startPopView.clipsToBounds = false
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.showAnimate()
        sleep(5)
        
        // TODO: 투명배경 설정이 왜 안되지..?ㅠㅠ
    }
    
    // MARK:- viewDidAppear 선언
    
    override func viewDidAppear(_ animated: Bool) {
        setupAnimation()
      //If you are using Storyboard
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {

            //If your first viewController is NOT in Navigation stack
            if let mainViewController = UIStoryboard(name: "MainView", bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController {
                
            self.dismiss(animated: false, completion: nil)
                // TODO: dismiss 추가했더니 이전뷰로 돌아가벌임... 머지 이후 라운드 진행뷰로 넘어가기
            self.present(mainViewController, animated: false, completion: nil)
            mainViewController.modalPresentationStyle = .fullScreen
                mainViewController.modalTransitionStyle = .coverVertical
            }
        }
    }
    
    // MARK:- 함수 선언
    
    func setupAnimation(){
        
        let width = lottieView.bounds.size.width
        let height = lottieView.bounds.size.height
        
        animationView.frame = lottieView.bounds
        animationView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: width, height: height))
        //어떤 jsonv파일을 쓸지
        animationView.animation = Animation.named("real_loading")
        //화면에 적합하게
        animationView.contentMode = .scaleAspectFit
        //반복되게
        animationView.loopMode = .loop
        //실행
        animationView.play()
        //view안에 Subview로 넣어준다
        lottieView.insertSubview(animationView, at: 0)
    }

}
