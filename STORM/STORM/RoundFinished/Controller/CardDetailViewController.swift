//
//  CardDetailViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/19.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

enum ViewMode {
    case round
    case scrap
}

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var roundPurposeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var drawingImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var memoView: UITextView!
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var topConstOfInfoView: NSLayoutConstraint!
    
    lazy var cards: [Card] = []
    lazy var scrappedCards: [CardItem] = []
    lazy var index: Int = 0
    lazy var isEdit: Bool = false
    lazy var viewMode: ViewMode = .round
    lazy var cardsMemo: [Int:String] = [:]
    lazy var isScrapped: Bool = false
    lazy var cardIndex: Int = 0
    lazy var projectName = ""
    var topConst: CGFloat!
    
    @IBAction func didPressLeftBtn(_ sender: UIButton) {
        if isEdit == false {
            
            if index >= 1 {
            index -= 1
            }
        
            if viewMode == .round {
                updateRoundCard(index: index)
            } else {
                print("좌측 버튼 \(index)")
                updateScrapCard(index: index)
            }
        }
    }
    
    @IBAction func didPressRightBtn(_ sender: UIButton) {
        if isEdit == false {
            
            if index < max(cards.count - 1, scrappedCards.count - 1) {
                index += 1
            }

            if viewMode == .round {
                updateRoundCard(index: index)
            } else {
                print("우측 버튼 \(index)")
                updateScrapCard(index: index)
            }
        }
    }
    
    @IBAction func didPressHeartBtn(_ sender: UIButton) {
        if ProjectSetting.shared.scrapCards[self.index] == false {
            NetworkManager.shared.scrapCard(cardIdx: cardIndex) { (response) in
                let heartFillImage = UIImage(systemName: "heart.fill")
                sender.setImage(heartFillImage, for: .normal)
                sender.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
                ProjectSetting.shared.scrapCards[self.index] = true
//                self.isScrapped = true
            }
        } else {
            NetworkManager.shared.cancelScrap(cardIdx: cardIndex) { (response) in
                let heartImage = UIImage(systemName: "heart")
                sender.setImage(heartImage, for: .normal)
                sender.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
                ProjectSetting.shared.scrapCards[self.index] = false
//                self.isScrapped = false
            }
        }
    }
    
    @IBAction func didPressSave(_ sender: UIButton) {
        print("메모뷰 텍스트~ \(memoView.text)")
        
        if memoView.text.isEmpty == true {
            return
        } else if cardsMemo[index] == nil {
            addCardMemo(cardIndex: index)
        } else {
            modifyMemo(cardIndex: index)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        if viewMode == .round {
            updateRoundCard(index: index)
//            guard let content = cards[index].memo_content else {return}
//            memoView.text = content
        } else {

            updateScrapCard(index: index)
//            guard let content = scrappedCards[index].memo_content else {return}
//            memoView.text = content
        }
        
        shadowView.addRoundShadow(contentView: contentView, cornerRadius: 15)

        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2

        self.setNaviTitle()
        
        memoView.font = UIFont(name: "NotoSansCJKkr-Regular", size: 13)
        memoView.textColor = UIColor.placeholderColor

        projectNameLabel.text = projectName
        
        print(projectNameLabel.text)
        
        topConst = topConstOfInfoView.constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.memoView.endEditing(true)
        topConstOfInfoView.constant = topConst
        isEdit = false
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            topConstOfInfoView.constant = -keyboardHeight + 69  
            isEdit = true
        }
    }
    
    func updateRoundCard(index: Int) {
        
        guard index >= 0 && index <= cards.count - 1 else {return}
        
        let card = cards[index]
        
        guard let cardIdx = card.card_idx else {return}
        
        cardIndex = cardIdx
        
        if card.card_img == nil {
            drawingImageView.isHidden = true
            textView.isHidden = false
            
            guard let cardText = card.card_txt, let userImageUrl = card.user_img else {return}
            
            textView.text = cardText
            profileImageView.kf.setImage(with: URL(string: userImageUrl))

        } else {
            textView.isHidden = true
            drawingImageView.isHidden = false
            
            guard let cardImageUrl = card.card_img, let userImageUrl = card.user_img else {return}
            
            drawingImageView.kf.setImage(with: URL(string: cardImageUrl))
            profileImageView.kf.setImage(with: URL(string: userImageUrl))
        }

        cardsMemo[index] = card.memo_content
        
        memoView.text = (card.memo_content != nil) ? card.memo_content! : ""
        
        if ProjectSetting.shared.scrapCards[index] == true {
            let heartFillImage = UIImage(systemName: "heart.fill")
            heartButton.setImage(heartFillImage, for: .normal)
            heartButton.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
        //            isScrapped = true
        } else {
            let heartImage = UIImage(systemName: "heart")
            heartButton.setImage(heartImage, for: .normal)
            heartButton.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        //            isScrapped = false
        }
    }
    
    func updateScrapCard(index: Int) {
        
        guard index >= 0 && index <= scrappedCards.count - 1 else {return}
        
        let card = scrappedCards[index]
        
        cardIndex = card.card_idx
        
        roundLabel.text = "ROUND \(card.round_number)"
        roundPurposeLabel.text = card.round_purpose
        timeLabel.text = "총 \(Int(card.round_time))분 소요"
        
        if card.card_img == nil {
            drawingImageView.isHidden = true
            textView.isHidden = false
            
            guard let cardText = card.card_txt, let userImageUrl = card.user_img else {return}
            
            textView.text = cardText
            profileImageView.kf.setImage(with: URL(string: userImageUrl))

        } else {
            drawingImageView.isHidden = false
            textView.isHidden = true
            
            
            guard let cardImageUrl = card.card_img, let userImageUrl = card.user_img else {return}
            
            drawingImageView.kf.setImage(with: URL(string: cardImageUrl))
            profileImageView.kf.setImage(with: URL(string: userImageUrl))
            
        }
        
        cardsMemo[index] = card.memo_content
        
        memoView.text = (card.memo_content != nil) ? card.memo_content! : ""
        
        
        if ProjectSetting.shared.scrapCards[index] == true {
            let heartFillImage = UIImage(systemName: "heart.fill")
            heartButton.setImage(heartFillImage, for: .normal)
            heartButton.tintColor = UIColor(red: 236/255, green: 101/255, blue: 101/255, alpha: 1)
//            isScrapped = true
        } else {
            let heartImage = UIImage(systemName: "heart")
            heartButton.setImage(heartImage, for: .normal)
            heartButton.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
//            isScrapped = false
        }
    }
    
    func addCardMemo(cardIndex: Int) {
        guard let content = memoView.text else {return}
        
        NetworkManager.shared.addCardMemo(cardIdx: cardIndex, memoContent: content) { (response) in
            
            let toastFrame = CGRect(x: self.view.center.x, y: self.shadowView.frame.origin.y + self.shadowView.frame.height + 10, width: self.memoView.frame.width * 0.856, height: self.memoView.frame.height * 0.362)
            
            if response?.status == 200 {
                self.cardsMemo[self.index] = content
                self.showToast(message: "메모가 저장되었습니다", frame: toastFrame)
            } else {
                self.showToast(message: "메모가 저장 실패", frame: toastFrame)
            }
        }
    }
    
    func modifyMemo(cardIndex: Int) {
        guard let content = memoView.text else {return}
        
        NetworkManager.shared.modifyCardMemo(cardIdx: cardIndex, memoContent: content) { (response) in
            
            let toastFrame = CGRect(x: self.view.center.x, y: self.shadowView.frame.origin.y + self.shadowView.frame.height + 10, width: self.memoView.frame.width * 0.856, height: self.memoView.frame.height * 0.362)
            
            if response?.status == 200 {
                self.cardsMemo[self.index] = content
                self.showToast(message: "메모가 수정 되었습니다", frame: toastFrame)
            } else {
                self.showToast(message: "메모가 수정 실패", frame: toastFrame)
            }
        }
    }
}
