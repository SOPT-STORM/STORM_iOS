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
    
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var startPopView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startPopView.layer.cornerRadius = 15
        startPopView.addShadow(width: 1, height: 3, 0.2, 5)
        startPopView.clipsToBounds = false
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupAnimation()
    }
    
    let animationView = AnimationView()
    
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
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
            self.view.alpha = 0.0;
        }, completion: {(finished : Bool)   in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
