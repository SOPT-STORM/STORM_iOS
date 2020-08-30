//
//  CameraPopUpViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/04.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

protocol presentPhotoLibrary {
    func photoLibrary()
}

class CameraPopUpViewController: UIViewController,UIImagePickerControllerDelegate {
    
    // MARK:- IBOutlet
    //@IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dimmerView: UIView!
    
    
    
    // MARK:- 변수
    var backImage: UIImage?
    var delegate: presentPhotoLibrary?
    var cardStartingTopConstant: CGFloat = 200.0
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뒷배경
        backImageView.image = backImage
        
        // 카드뷰 숨겨놓기
        if let safeAreaHeight = UIApplication.shared.windows.last?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.windows.last?.safeAreaInsets.bottom {
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        
        // 뒷배경 tap gestureRecognizer
        let  dimmerViewTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerViewTap)
        dimmerView.isUserInteractionEnabled = true
        
        
        // 전체VC gestureRecognizer
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        
        self.view.addGestureRecognizer(viewPan)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 카드뷰 보이기
        showCard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 카드뷰 radius
        cardView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
    }
    
    // MARK:-
    @IBAction func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        
        // 카드뷰 숨기기
        print("배경눌림")
        hideCard()
    }
    
    @IBAction func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        let translation = panRecognizer.translation(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            cardStartingTopConstant = cardViewTopConstraint.constant
        case .changed:
            if self.cardStartingTopConstant + translation.y > cardStartingTopConstant {
                self.cardViewTopConstraint.constant = self.cardStartingTopConstant + translation.y
            }
        case .ended:
            if let safeAreaHeight = UIApplication.shared.windows.last?.safeAreaLayoutGuide.layoutFrame.size.height,
                let bottomPadding = UIApplication.shared.windows.last?.safeAreaInsets.bottom {
                if self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.79 {
                    showCard()
                } else {
                    hideCard()
                }
            }
        default:
            break
        }
        
    }
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        if (self.presentingViewController != nil){
            
            self.dismiss(animated: false) {
                self.delegate?.photoLibrary()
            }
        }
    }
    
    @IBAction func selectBasicImage(_ sender: UIButton) {
        NotificationCenter.default.post(
        name: NSNotification.Name(rawValue: "SetBasicImage"),
        object: nil)
        self.dismiss(animated: false)
    }
    
    
    
    // MARK:- 함수
    func showCard() {
        self.view.layoutIfNeeded()
        
        if let safeAreaHeight = UIApplication.shared.windows.last?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.windows.last?.safeAreaInsets.bottom {
            cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) * 0.77
        }
        
        let showCard = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations: { self.view.layoutIfNeeded()})
        
        showCard.addAnimations({
             self.dimmerView.alpha = 0.6
        })
        
        showCard.startAnimation()
    }
    
    func hideCard() {
        self.view.layoutIfNeeded()
        
        if let safeAreaHeight = UIApplication.shared.windows.last?.safeAreaLayoutGuide.layoutFrame.size.height, let bottomPadding = UIApplication.shared.windows.last?.safeAreaInsets.bottom {
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        
        let hideCard = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations: { self.view.layoutIfNeeded()})
        
        hideCard.addAnimations({
             self.dimmerView.alpha = 0.0
        })
        
        hideCard.addCompletion({ position in
            if position == .end {
                if (self.presentingViewController != nil){
                    self.dismiss(animated: false, completion: nil)
                }
            }
        })
        
        hideCard.startAnimation()
        
    }
}
