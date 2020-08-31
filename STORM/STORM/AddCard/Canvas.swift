//
//  Canvas.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    var lines = [[CGPoint]]()
    var restoreLines = [[CGPoint]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    func undo() {
        guard let line = lines.popLast() else {return}
        restoreLines.append(line)
        
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        restoreLines.removeAll()
        setNeedsDisplay()
    }
    
    func redo() {
        guard let line  = restoreLines.popLast() else {return}
        lines.append(line)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {

        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return} // 2D그림을 그리기 위한 context
        
        let color = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1).cgColor // 78 78 78 
        context.setStrokeColor(color) // 색상 검정 설정
        context.setLineWidth(5) // 선 굵기 5 설정
        context.setLineCap(.round) // line의 endpoint 라운드 설정
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p) // 배열의 첫번째 p: CGPoint지점에서 새로운 subpath 시작
                } else {
                    context.addLine(to: p) // p 까지 직선 라인 추가
                }
            }
        }
    
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]()) // 사용자가 첫번째 화면 터치시 lines 배열에 CGPoint 배열 추가
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else {return} // 사용자의 touch move event 발생 시, point변수에 터치지점 좌표 저장
        
        guard var lastLine = lines.popLast() else {return}
        
        lastLine.append(point) // lines 배열의 마지막 원소(line: [CGPoint])를 빼낸 후 point 추가
        lines.append(lastLine) // lines 배열
        
        setNeedsDisplay() // setNeedDisplay() 호출 - 시스템에 뷰가 다시 그려져야 함을 알리는 메소드로 뷰를 다시 그려 업데이트 함, setNeedsDisplay() 호출 시 draw(_ rect: CGRect) 실행
    }
}

