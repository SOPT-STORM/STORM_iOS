//
//  DrawingViewController.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/03.
//  Copyright © 2020 Team STORM. All rights reserved.
//

// feature - Drawing 

import UIKit

class Canvas: UIView {
    
    // public func
    
    func undo() {
        guard let line = lines.popLast() else {return}
        restoreLines.append(line)
        setNeedsDisplay()
        
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
        
    }
    
    func restore() {
        guard let line = restoreLines.first else {return}
        restoreLines.removeFirst()
        lines.append(line)
        setNeedsDisplay()
    }
    
    var lines = [[CGPoint]]()
    var restoreLines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {
        // custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
//        let startPoint = CGPoint(x: 0, y: 0)
//        let endPoint = CGPoint(x: 100, y: 100)
//
//
//        context.move(to: startPoint)
//        context.addLine(to: endPoint)
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(7)
        context.setLineCap(.butt)
        
        
        lines.forEach { (line) in
            print("라인: \(line)")
            for (i, p) in line.enumerated() {
                print("아이피\(i), \(p)")
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
    
        context.strokePath()
    }
    
//    var line = [CGPoint]()
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TouchesBegan 실행")
        lines.append([CGPoint]())
    }
    
    // track the finger as we move across screen
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TouchesMoved 실행")
        
        guard let point = touches.first?.location(in: nil) else {return}
        
//        print(point)
        
        guard var lastLine = lines.popLast() else {return}
        
//        var lastLine = lines.last
        lastLine.append(point)
        lines.append(lastLine)
        
//        line.append(point)
        
        setNeedsDisplay()
    }
}

class DrawingViewController: UIViewController {
    
    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo) , for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear) , for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    let restoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("restore", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleRestore) , for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleRestore() {
        canvas.restore()
    }

    override func loadView() {
        self.view = canvas
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    fileprivate func setupLayout() {
        //        view.addSubview(canvas)
        //        canvas.frame = view.frame
        
        print("실행")
        
        canvas.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            restoreButton
        ])
        
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
