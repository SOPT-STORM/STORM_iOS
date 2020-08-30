//
//  DrawingViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

// feature - Drawing 

import UIKit

enum CardMode {
    case drawing
    case memo
}

class AddCardViewController: UIViewController {
    
    let projectIndex = UserDefaults.standard.integer(forKey: "projectIndex")
    let roundIndex = UserDefaults.standard.integer(forKey: "roundIndex")

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var canvasView: Canvas!
    @IBOutlet weak var memoView: UITextView!
    @IBOutlet weak var roundGoalLabel: UILabel!
    
    @IBOutlet weak var drawingBtn: UIButton!
    @IBOutlet weak var textBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var redoBtn: UIButton!
    
    @IBOutlet weak var applicationBtn: UIButton!
    @IBOutlet weak var botConstOfMemoView: NSLayoutConstraint!
    
    var mode: CardMode = .drawing
    var memoViewHeight: CGFloat!
    var projectName = "프로젝트 이름"
    var roundGoal = "라운드 목표"
    var round = "round"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameLabel.text = projectName
        roundGoalLabel.text = roundGoal
        roundLabel.text = round
            
        self.setNaviTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "myprojectBtnBack" ), style: .plain, target: self, action: #selector(back))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        toolbarSetup()
        memoSetup()

        shadowView.addRoundShadow(contentView: memoView, cornerRadius: 15)
        shadowView.addRoundShadow(contentView: canvasView, cornerRadius: 15)
    }

    override func viewWillAppear(_ animated: Bool) {
        TimeManager.shared.makeAndFireTimer { (endTime) in
            let startTime = Date(timeIntervalSinceNow: 0)
            let time = Int(endTime.timeIntervalSince(startTime))
            
            if time >= 0 {
                let minute = time/60
                let second = time - minute*60
                self.remainingTime.text = String(format: "총 %02d:%02d 남음", minute, second)
            }
            
            if time <= 0 {
                TimeManager.shared.invalidateTimer()
                
                let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "roundFinishedPopup") as! RoundFinishedPopup
                
                vc.delegate = self
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            TimeManager.shared.invalidateTimer()
        }
    }
        
    @IBAction func didPressText(_ sender: UIButton) {
        mode = .memo
        memoView.isHidden = false

        textBtn.setImage(UIImage(named: "text_selected"), for: .normal)
        drawingBtn.setImage(UIImage(named: "drawing_deselected"), for: .normal)
        
        undoBtn.isHidden = true
        redoBtn.isHidden = true
    }
    
    @IBAction func didPressDrawing(_ sender: UIButton) {
        mode = .drawing
        memoView.isHidden = true
        
        drawingBtn.setImage(UIImage(named: "drawing_selected"), for: .normal)
        textBtn.setImage(UIImage(named: "text_deselected"), for: .normal)
        
        undoBtn.isHidden = false
        redoBtn.isHidden = false
    }
    
    @IBAction func didPressUnDo(_ sender: UIButton) {
        canvasView.undo()
    }
    
    @IBAction func didPressReDo(_ sender: UIButton) {
        canvasView.redo()
    }
    
    @IBAction func didPressClean(_ sender: UIButton) {
        if mode == .drawing{
            canvasView.clear()
        }else{
            memoView.text = ""
        }
    }
    
    @IBAction func didPressApplication(_ sender: UIButton) {
        
        let toastWidth = self.view.frame.width*0.573
        let toastFrame = CGRect(x: self.view.center.x, y: self.view.frame.height*0.674, width: toastWidth, height: toastWidth*0.227)
        
        if mode == .memo {
            if memoView.text == "" {
                self.showToast(message: "카드를 입력해주세요", frame: toastFrame)
                return
            }
            
            guard let content = memoView.text else {return}
            
            NetworkManager.shared.addCard(projectIdx: ProjectSetting.shared.projectIdx!, roundIdx: ProjectSetting.shared.roundIdx!, cardImg: nil, cardTxt: content) {
                
                guard let vc = self.navigationController?.viewControllers.first as? AllRoundViewController else {return}
                
                self.showToast(message: "카드가 추가되었습니다", frame: toastFrame)
                let card = addedCard(card_drawing: nil, card_text: content)
                vc.cardList.insert(card, at: 0)
                self.memoView.text = ""
            }
        } else {
            if canvasView.lines.isEmpty {
                self.showToast(message: "카드를 입력해주세요", frame: toastFrame)
                return
            }
                
            let img = canvasView.asImage()
//            let scaledImg = UIImage.scale(image: img, by: 0.7)
            
            self.showToast(message: "카드가 추가되었습니다", frame: toastFrame)
            self.canvasView.clear()
            
            NetworkManager.shared.addCard(projectIdx: ProjectSetting.shared.projectIdx!, roundIdx: ProjectSetting.shared.roundIdx!, cardImg: img, cardTxt: nil) {
                
                guard let vc = self.navigationController?.viewControllers.first as? AllRoundViewController else {return}
                
                let card = addedCard(card_drawing: img, card_text: nil)
                vc.cardList.insert(card, at: 0)
            }
        }
    }
        
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
        botConstOfMemoView.constant = 0
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            botConstOfMemoView.constant = keyboardHeight - (self.view.frame.height - canvasView.frame.origin.y - canvasView.frame.height)
            
            print(self.view.frame.height,canvasView.frame.origin.y,memoView.frame.height)
            print(keyboardHeight, botConstOfMemoView.constant)
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
        
    func memoSetup() {
        memoView.isHidden = true
        memoView.delegate = self
        memoViewHeight = memoView.frame.size.height
        memoView.textContainerInset = UIEdgeInsets(top: 29, left: 32, bottom: 29, right: 32)
        memoView.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        memoView.font = UIFont(name: "NotoSansCJKkr-Medium", size: 17)
        memoView.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.memoView.endEditing(true)
        botConstOfMemoView.constant = 0
    }
}

extension AddCardViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let lines = Int(memoView.contentSize.height / memoView.font!.lineHeight)
        let maxOfContentsLine = Int(((memoViewHeight - 29*2) / memoView.font!.lineHeight))

        if text == "" {
            return true
        }

        if lines <= maxOfContentsLine {
            return true
        } else {
            return false
        }
    }
}

extension AddCardViewController: PresentVC {
    func presentVC() {
    if let roundMeetingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "roundMeetingVC") as? RoundMeetingViewController {

    let naviController = UINavigationController(rootViewController: roundMeetingVC)
    naviController.modalPresentationStyle = .fullScreen
    
    self.present(naviController, animated: false, completion: nil)
        }
    }
}

