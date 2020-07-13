//
//  ScrapCardMemoViewController.swift
//  STORM
//
//  Created by 이지윤 on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class ScrapCardMemoViewController: UIViewController {
    
    @IBOutlet weak var roundNameLabel: UILabel!
    @IBOutlet weak var roundIndexLabel: UILabel!
    @IBOutlet weak var roundGoalLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 40, right: 12)
        memoTextView.text = "Memo"
        memoTextView.textColor = UIColor.placeholderColor
        memoTextView.font = UIFont(name: "Noto Sans CJK KR Medium", size: 13)
        memoTextView.delegate = self
        memoTextView.setRadius(radius: 7)
        memoTextView.dropShadow(color: .black, opacity: 0.16, offSet: CGSize(width: 0, height: 3), radius: 2.5)
        memoTextView.clipsToBounds = true
        
    }
    
   var isScrap = false
    
    @IBAction func scrapButtonDidPress(_ sender: UIButton) {
           if isScrap {
                scrapButton.setImage(UIImage(named: "roundviewScrollSelectedBtnHeart2"), for: .normal)
            } else {
                scrapButton.setImage(UIImage(named: "roundviewScrollUnselectedBtnHeart2"), for: .normal)
            }
            isScrap = !isScrap
        }
    }
    

// MARK: - Extension

extension ScrapCardMemoViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoTextView.textColor == UIColor.placeholderColor {
            memoTextView.text = nil
            memoTextView.textColor = UIColor.textDefaultColor
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text.isEmpty {
            memoTextView.text = "Memo"
            memoTextView.textColor = UIColor.placeholderColor
        }
    }
    
    
}
