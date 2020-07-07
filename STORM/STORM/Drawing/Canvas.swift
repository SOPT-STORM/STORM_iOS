//
//  Canvas.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

enum undoMode {
    case append
    case remove
}

class Canvas: UIView {
    
    // public func
//
//    lazy var didCleared: Bool = false
    
    var mode: undoMode = .remove
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    func undo() {
        
//        if lines.isEmpty {
//            mode = .append
//        } else if restoreLines.isEmpty {
//            mode = .remove
//        }
//
//        if mode == .append {
//            guard let line  = restoreLines.popLast() else {return}
//            lines.append(line)
//        } else{
//            guard let line = lines.popLast() else {return}
//            restoreLines.append(line)
//        }
        
        guard let line = lines.popLast() else {return}
        restoreLines.append(line)
        
        setNeedsDisplay()
        
//            guard let line  = restoreLines.popLast() else {return}
//            lines.append(line)
//            lines = restoreLines
//            restoreLines.removeAll()
//
//        } else {
//            guard let line = lines.popLast() else {return}
//            restoreLines.append(line)
//        }
//        guard let line = lines.popLast() else {return}
//        restoreLines.append(line)
//        setNeedsDisplay()
    }
    
    func clear() {
        restoreLines = lines
        
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func restore() {
//        if lines.isEmpty {
//            lines = restoreLines
//            restoreLines.removeAll()
//        } else {
//            guard let line = restoreLines.popLast() else {return}
//            lines.append(line)
//        }
        
//        if lines.isEmpty {
//            mode = .append
//        } else if restoreLines.isEmpty {
//            mode = .remove
//        }
//
//        if mode == .append {
//            guard let line  = restoreLines.popLast() else {return}
//            lines.append(line)
//        } else{
//            guard let line = lines.popLast() else {return}
//            restoreLines.append(line)
//        }
        
//        if lines.isEmpty {
//            lines = restoreLines
//            restoreLines.removeAll()
//        } else {
//            guard let line  = restoreLines.popLast() else {return}
//            lines.append(line)
//        }
        
        guard let line  = restoreLines.popLast() else {return}
        lines.append(line)
        setNeedsDisplay()
    }
    
    var lines = [[CGPoint]]()
    var restoreLines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {

        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(3)
//        context.setLineCap(.butt)
        context.setLineCap(.round)
        
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else {return}
        
        guard var lastLine = lines.popLast() else {return}
        
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    
}

