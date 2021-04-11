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

        lines.forEach { (line) in
            let bezierPath = UIBezierPath()
            bezierPath.lineWidth = 5
            bezierPath.lineJoinStyle = .round
            bezierPath.usesEvenOddFillRule = true

            var prevPoint: CGPoint?
            var isFirst = true

            for point in line {
                if let prevPoint = prevPoint {
                    let midPoint = CGPoint(
                        x: (point.x + prevPoint.x) / 2,
                        y: (point.y + prevPoint.y) / 2
                        )
                    if isFirst {
                        bezierPath.addLine(to: midPoint)
                    }
                    else {
                        bezierPath.addQuadCurve(to: midPoint, controlPoint: prevPoint)
                    }
                    isFirst = false
                }
                else {
                    bezierPath.move(to: point)
                }
                prevPoint = point
            }

            if let prevPoint = prevPoint {
                bezierPath.addLine(to: prevPoint)
                UIColor(red: 78/255, green: 78/255, blue: 78/255, alpha: 1).set()
                bezierPath.stroke()
            }
        }
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




