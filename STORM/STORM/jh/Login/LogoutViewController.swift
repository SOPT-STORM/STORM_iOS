//
//  LogoutViewController.swift
//  STORM
//
//  Created by 김지현 on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase
import CodableFirebase

class LogoutViewController: UIViewController, FUIAuthDelegate {

    // MARK:- 함수 선언
    
    @IBAction func logoutpressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
