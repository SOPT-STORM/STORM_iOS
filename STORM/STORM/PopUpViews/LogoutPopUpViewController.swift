//
//  LogoutPopUpViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class LogoutPopUpViewController: UIViewController {
    
    // MARK:- IBOutlet
    
    @IBOutlet weak var popUpView: UIView!
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.roundCorners(corners: .allCorners, radius: 15.0)
    }
    
    // MARK:- IBAction
    
    @IBAction func logoutButtonDidTap(_ sender: UIButton) {
        print("delete email,pwd")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "pwd")
        UserDefaults.standard.removeObject(forKey: "index")
        
//        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        
        guard let loginVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else {return}
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.rootViewController = loginVC
    }
    
    @IBAction func logoutCancelDidTap(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
