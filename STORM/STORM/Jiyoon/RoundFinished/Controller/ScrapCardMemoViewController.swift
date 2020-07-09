//
//  ScrapCardMemoViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ScrapCardMemoViewController: UIViewController {

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    func setNavigationBar
        () {
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.clipsToBounds = true
        navigationBar.isTranslucent = true
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width * (106/375))
        
        //TODO: height 계산 어떻게 하더라...
        
        guard let titleImage = UIImage(named: "imgLogo") else { return }
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = titleImageView
        
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "roundviewBtnBack"),
                                                               style: .plain,
                                                               target: self,
                                                               action: nil)
        
        let myPageButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "roundviewBtnMypage"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = myPageButton
        backButton.tintColor = .white
        myPageButton.tintColor = .white
    }

}


// TODO: 버튼 돌려쓰기, 버튼 위치를 어떻게 맞춰야 하지??
