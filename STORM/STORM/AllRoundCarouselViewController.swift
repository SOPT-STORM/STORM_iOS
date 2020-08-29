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
    
    @IBOutlet weak var memoTextLabel: UILabel!
    
    @IBOutlet weak var nextRoundNotificationView: UIView!
    
    @IBOutlet weak var botConstOfnextRoundNoti: NSLayoutConstraint!
    
    lazy var cards: [Card] = []
    lazy var cellIndexPath = IndexPath()
    lazy var contentOffsetForIdx: CGFloat = 0
    lazy var isWaitNextRound: Bool = false
    
    var topConst: CGFloat!
    var isInit: Bool = false
    var cardIdx = 0
    lazy var cardsMemo: [Int:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isWaitNextRound == true {
            botConstOfnextRoundNoti.constant = 0
        }
        
        nextRoundNotificationView.cornerRadius = 20
        nextRoundNotificationView.layer.maskedCorners = [.layerMinXMinYCorner, . layerMaxXMinYCorner]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        memoView.delegate = self
        
        memoView.font = UIFont(name: "NotoSansCJKkr-Regular", size: 13)
        memoView.textColor = UIColor.placeholderColor
        memoView.text = "Memo"
        
        topConst = topConstOfIndex.constant
        
//        toolbarSetup()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.collectionView.scrollToItem(at: self.cellIndexPath, at: .centeredHorizontally, animated: false)
            
            self.cardIndexLabel.text = "(\(self.cellIndexPath.row + 1)/\(self.cards.count))"
            
            self.cardIdx = self.cellIndexPath.row
            
            self.memoView.text = self.cardsMemo[self.cardIdx]
            
            if self.cardsMemo[self.cardIdx] == nil {
                self.memoTextLabel.isHidden = false
            } else {
                self.memoTextLabel.isHidden = true
            }
        })
        
        self.setNaviTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "myprojectBtnBack" ), style: .plain, target: self, action: #selector(back))
    }
    
    @IBAction func didPressSave(_ sender: UIButton) {
        print(memoView.text.count,cardsMemo[cardIdx], memoView.text, memoView.text.isEmpty)
        
        if memoView.text.isEmpty == true {
            return
        } else if cardsMemo[cardIdx] == nil {
            addCardMemo()
        } else {
            modifyMemo()
        }
    }
    
    func showUpNextRoundNoti() {
        UIView.animate(withDuration: 1) {
            self.botConstOfnextRoundNoti.constant = 0
            self.view.layoutIfNeeded()
        }
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
    
    func addCardMemo() {
        guard let content = memoView.text, let idx = cards[cardIdx].card_idx else {return}
        
        NetworkManager.shared.addCardMemo(cardIdx: idx, memoContent: content) { (response) in
            
            let toastFrame = CGRect(x: self.view.center.x, y: self.memoBackgroundView.frame.origin.y - self.memoBackgroundView.frame.height*0.3851, width: self.memoView.frame.width * 0.856, height: self.memoView.frame.height * 0.362)
            
            if response?.status == 200 {
                self.cardsMemo[self.cardIdx] = content
                self.showToast(message: "메모가 저장되었습니다", frame: toastFrame)
            } else {
                self.showToast(message: "메모가 저장 실패", frame: toastFrame)
            }
        }
    }
    
    func modifyMemo() {
        guard let content = memoView.text, let idx = cards[cardIdx].card_idx else {return}
        
        print("카드 메모 수정")
        NetworkManager.shared.modifyCardMemo(cardIdx: idx, memoContent: content) { (response) in
            
            let toastFrame = CGRect(x: self.view.center.x, y: self.memoBackgroundView.frame.origin.y - self.memoBackgroundView.frame.height*0.3851, width: self.memoView.frame.width * 0.856, height: self.memoView.frame.height * 0.362)
            
            if response?.status == 200 {
                self.cardsMemo[self.cardIdx] = content
                self.showToast(message: "메모가 수정 되었습니다", frame: toastFrame)
            } else {
                self.showToast(message: "메모가 수정 실패", frame: toastFrame)
            }
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
        
        cardsMemo[indexPath.row] = card.memo_content
        
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
        print("카드 인덱스~~ \(cardIdx)")
        cardIdx = Int(round(self.collectionView.contentOffset.x / self.contentOffsetForIdx))
        cardIndexLabel.text = "(\(cardIdx + 1)/\(cards.count))"
        
        memoView.text = cardsMemo[cardIdx]
        
        if cardsMemo[self.cardIdx] == nil {
            memoTextLabel.isHidden = false
        } else {
            memoTextLabel.isHidden = true
        }
    }
}

extension AllRoundCarouselViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        memoTextLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            memoTextLabel.isHidden = false
        }
    }
    
}


