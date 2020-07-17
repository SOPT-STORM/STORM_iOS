//
//  AllRoundCarouselViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/17.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class AllRoundCarouselViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var botConstOfMemo: NSLayoutConstraint!
    
    
    fileprivate var colors: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.yellow,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow ,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green]
    
    var botConst: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCollectionView()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        botConst = botConstOfMemo.constant
        
        toolbarSetup()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            botConstOfMemo.constant = keyboardHeight + 81
        }
    }

    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
                    
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                    
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
            
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))

        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
//        memoView.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
        botConstOfMemo.constant = botConst
        print(botConstOfMemo.constant)
       }
    
    func addCollectionView(){

        let layout = CarouselFlowLayout()
            
        layout.itemSize = CGSize(width: collectionView.frame.size.width*0.811, height: collectionView.frame.size.height) // 0.73333

            layout.scrollDirection = .horizontal
            
            layout.sideItemScale = 0.849//0.757
            layout.sideItemAlpha = 0.5

            collectionView.collectionViewLayout = layout
            
  
            self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
 
            self.collectionView?.delegate = self
            self.collectionView?.dataSource = self

            self.collectionView?.register(CarouselCell.self, forCellWithReuseIdentifier: "cellId")

            let spacingLayout = self.collectionView?.collectionViewLayout as! CarouselFlowLayout
 
            spacingLayout.spacingMode = CarouselFlowLayoutSpacingMode.fixed(spacing: -200) //170

            self.view.addSubview(self.collectionView!)
            }

}

extension AllRoundCarouselViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CarouselCell

        cell.customView.backgroundColor = colors[indexPath.row]
        return cell
    }
}


