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

    
    @IBAction func logoutpressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
