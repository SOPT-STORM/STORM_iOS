//
//  RoundSettingForMemberViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/09.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit
import Lottie

class RoundSettingForMemberViewController: UIViewController {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var loadingView: AnimationView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animation = Animation.named("loading3")
        loadingView.animation = animation
        loadingView.contentMode = .scaleAspectFit
        loadingView.play()
        loadingView.isHidden = true
        

       // 완료되는 시점의 코드 넣기 -> loadingView.stop()
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
