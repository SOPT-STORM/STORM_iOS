//
//  DoneSignUpViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/08/29.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class DoneSignUpViewController: UIViewController {
    
    // MARK:- IBOutlet
    
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        doneButton.addShadow(cornerRadus: 10, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.2, shadowRadius: 3)
    }
    
    // MARK:- IBAction
    
    @IBAction func doneButtonDidPressed(_ sender: UIButton) {
        guard let loginVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else {return}
        
        let naviController = UINavigationController(rootViewController: loginVC)
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.rootViewController = naviController
    }
}
