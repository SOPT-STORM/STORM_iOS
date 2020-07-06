//
//  DrawingViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

// feature - Drawing 

import UIKit

class DrawingViewController: UIViewController {
    
//    let canvas = Canvas()
    
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var canvasView: Canvas!
    @IBOutlet weak var applicationBtn: UIButton!
    
    
//    let undoButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("undo", for: .normal)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(handleUndo) , for: .touchUpInside)
//        return button
//    }()
    
//    @objc fileprivate func handleUndo() {
//        canvas.undo()
//    }
    
//    let clearButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("clear", for: .normal)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(handleClear) , for: .touchUpInside)
//        return button
//    }()
    
//    @objc fileprivate func handleClear() {
//        canvas.clear()
//    }
    
//    let restoreButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("restore", for: .normal)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(handleRestore) , for: .touchUpInside)
//        return button
//    }()
    
//    @objc fileprivate func handleRestore() {
//        canvas.restore()
//    }

//    override func loadView() {
//        self.canvasView = canvas
//        print("로드뷰 실행")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        canvasView = canvas
//        canvasView.layer.cornerRadius = 10
//        self.canvasView = Canvas()
    }
        
    @IBAction func didPressText(_ sender: UIButton) {
    }
    
    @IBAction func didPressDrawing(_ sender: UIButton) {
    }
    
    @IBAction func didPressUnDo(_ sender: UIButton) {
        canvasView.undo()
    }
    
    @IBAction func didPressReDo(_ sender: UIButton) {
        canvasView.restore()
    }
    
    @IBAction func didPressClean(_ sender: UIButton) {
        canvasView.clear()
    }
    
    @IBAction func didPressApplication(_ sender: UIButton) {
    }
    
}
