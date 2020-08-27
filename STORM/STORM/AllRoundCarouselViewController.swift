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
    
    @IBOutlet weak var memoBackgroundView: UIView!
    
    @IBOutlet weak var memoView: UITextView!
    @IBOutlet weak var topConstOfIndex: NSLayoutConstraint!
    @IBOutlet weak var cardIndexLabel: UILabel!
    
    lazy var cards: [Card] = []
    lazy var cellIndexPath = IndexPath()
    lazy var contentOffsetForIdx: CGFloat = 0
    
    var topConst: CGFloat!
    var isInit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        memoView.delegate = self
        
        memoView.font = UIFont(name: "NotoSansCJKkr-Regular", size: 11)
        memoView.textColor = UIColor.placeholderColor
        memoView.text = "Memo"
        
        topConst = topConstOfIndex.constant
        
//        toolbarSetup()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.collectionView.scrollToItem(at: self.cellIndexPath, at: .centeredHorizontally, animated: false)
            
            self.cardIndexLabel.text = "(\(self.cellIndexPath.row)/\(self.cards.count))"
        })
        
        self.setNaviTitle()
    }
    
    @IBAction func didPressSave(_ sender: UIButton) {
        let toastFrame = CGRect(x: self.view.center.x, y: self.memoBackgroundView.frame.origin.y - self.memoBackgroundView.frame.height*0.3851, width: self.memoView.frame.width * 0.856, height: self.memoView.frame.height * 0.362)
        
        self.showToast(message: "메모가 저장되었습니다", frame: toastFrame)
    }
    
    
    override func viewDidLayoutSubviews() {
        if isInit == false {
            self.addCollectionView()
            isInit = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.memoView.endEditing(true)
        topConstOfIndex.constant = topConst
        self.collectionView.isScrollEnabled = true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            topConstOfIndex.constant = -keyboardHeight + 69  //-(keyboardHeight + 81)
            self.collectionView.isScrollEnabled = false
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
        memoView.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
        topConstOfIndex.constant = topConst
        self.collectionView.isScrollEnabled = true
       }
    
    func addCollectionView(){

        let layout = CarouselLayout()
                
        layout.itemSize = CGSize(width: collectionView.frame.size.width*0.796, height: collectionView.frame.height)
        
        print(collectionView.frame.size.height, collectionView.bounds.size.height)
        
        layout.sideItemScale = 0.698
        layout.spacing = -collectionView.frame.size.width*0.796*0.7848
        layout.isPagingEnabled = true
        
        collectionView.collectionViewLayout = layout
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        let drawingCarouselCell = UINib(nibName: "DrawingCarouselCell", bundle: nil)
        let memoCarouselCell = UINib(nibName: "MemoCarouselCell", bundle: nil)

        self.collectionView.register(drawingCarouselCell, forCellWithReuseIdentifier: "drawingCarouselCell")
        self.collectionView.register(memoCarouselCell, forCellWithReuseIdentifier: "memoCarouselCell")
        
        let scaledItemOffset =  (layout.itemSize.width - (layout.itemSize.width*(layout.sideItemScale + (1 - layout.sideItemScale)/2))) / 2
        
        let itemSpacing = layout.spacing - scaledItemOffset
        
        contentOffsetForIdx = layout.itemSize.width + itemSpacing
    }
    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo else { return }
//        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
//        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
//        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let keyboardHeight = keyboardSize.height
//        
//        textFieldYConstraint.constant = -keyboardHeight/2
//        roundIndexSetLabel.isHidden = true
//        stormLogoImage.isHidden = true
//        
//        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
//            self.view.layoutIfNeeded()
//        })
//    }
    
}

extension AllRoundCarouselViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = cards[indexPath.row]
        
        if card.card_img != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCarouselCell", for: indexPath) as! DrawingCarouselCell
            
            guard let userLink = card.user_img, let userUrl = URL(string: userLink), let drawingLink = card.card_img, let drawingUrl = URL(string: drawingLink) else {return UICollectionViewCell()}
            
            cell.userImgView.kf.setImage(with: userUrl)
            cell.drawingImgView.kf.setImage(with: drawingUrl )
            cell.index = card.card_idx

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoCarouselCell", for: indexPath) as! MemoCarouselCell
            
            guard let userLink = card.user_img, let userUrl = URL(string: userLink), let cardText = card.card_txt else {return UICollectionViewCell()}
            
            cell.userImage.kf.setImage(with: userUrl)
            cell.textView.text = cardText
            cell.index = card.card_idx
            
            return cell
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cardIdx = Int(round(self.collectionView.contentOffset.x / self.contentOffsetForIdx)) + 1
        cardIndexLabel.text = "(\(cardIdx)/\(cards.count))"
    }
}

extension AllRoundCarouselViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderColor {
            textView.text = nil
            textView.font = UIFont(name: "NotoSansCJKkr-Regular", size: 13)
            textView.textColor = UIColor.textDefaultColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.font = UIFont(name: "NotoSansCJKkr-Regular", size: 11)
            textView.textColor = UIColor.placeholderColor
            textView.text = "Memo"
        }
        
    }
    
}


