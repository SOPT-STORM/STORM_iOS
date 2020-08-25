//
//  TestViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/24.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var testStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let view1 = UIView()
//        view1.backgroundColor = .blue
//        view1.translatesAutoresizingMaskIntoConstraints = false
//
//        let view2 = UIView()
//        view2.backgroundColor = .black
//        view2.translatesAutoresizingMaskIntoConstraints = false
//
//        let view3 = UIView()
//        view3.backgroundColor = .red
//        view3.translatesAutoresizingMaskIntoConstraints = false
//
//        let views = [view1, view2, view3]
//
//        testStackView = setupStackView(views: views)
//
//        let stackView = UIStackView(arrangedSubviews: views)
//        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
//        stackView.spacing = 7
//        stackView.axis = .horizontal
//
//        self.view.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//

        let button = UIButton()
        button.setTitle("btn 1", for: .normal)
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false

        let button2 = UIButton()
        button2.setTitle("btn 2", for: .normal)
        button2.backgroundColor = UIColor.gray
        button2.translatesAutoresizingMaskIntoConstraints = false

        let button3 = UIButton()
        button3.setTitle("btn 3", for: .normal)
        button3.backgroundColor = UIColor.brown
        button3.translatesAutoresizingMaskIntoConstraints = false

        testStackView.alignment = .fill
        testStackView.distribution = .fillEqually
        testStackView.spacing = 8.0

        testStackView.addArrangedSubview(button)
        testStackView.addArrangedSubview(button2)
        testStackView.addArrangedSubview(button3)
    }
    
    func setupStackView(views: [UIView]) -> UIStackView {
       let stackView = UIStackView(arrangedSubviews: views)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func imgURLToImage(imgURLs:[String]) -> [UIImageView] {
        var imageViews: [UIImageView] = []
        
        for url in imgURLs {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: testStackView.frame.size.height, height: testStackView.frame.size.height))
            
            guard let imageURL = URL(string: url) else {return imageViews}
            
            imageView.kf.setImage(with: imageURL)
            imageViews.append(imageView)
            
            if imageViews.count >= 5 {
                break
            }
        }
        
        return imageViews
    }
  

}
