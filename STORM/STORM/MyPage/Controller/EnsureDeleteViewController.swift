//
//  EnsureDeleteViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/05.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class EnsureDeleteViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    var userPwd: String?
    var reason: String?
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 디자인
        self.setNaviTitle()
        self.view.tintColor = .stormRed
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "naviBackBtn" ), style: .plain, target: self, action: #selector(back))
    }
    
    override func viewDidLayoutSubviews() {
        whiteView.roundCorners(corners: [.topRight, .topLeft], radius: 30.0)
        
        deleteAccountButton.addShadow(cornerRadus: 7, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 2)
    }
    
    // MARK:- IBAction
    
    @IBAction func doWithdrawal(_ sender: UIButton) {
        deleteAccont()
    }
    
    // MARK:- func
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func deleteAccont() {

        guard let user_pwd = self.userPwd, let user_reason = self.reason else {return}
        NetworkManager.shared.withDrawal(userPwd: user_pwd, userReason: user_reason) { (response) in
            
            guard let loginVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else {return}
            
                let naviController = UINavigationController(rootViewController: loginVC)

                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                window?.rootViewController = naviController

        }
    }
    

}
