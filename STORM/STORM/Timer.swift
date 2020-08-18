//
//  Timer.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/04.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import Foundation

class TimeManager {
    static let shared = TimeManager()
    
    var timer: Timer!
    
//    var time: Int = 600
    var endTime = Date()
//    lazy var minute = Int()
//    lazy var second = Int()
    
//    func makeAndFireTimer(timeHandler: @escaping (Int, Int) -> Void) {
//        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[unowned self] (timer: Timer) in
//            
////            if self.time > 0 {
////            self.time -= 1
////            self.minute = self.time/60
////            self.second = self.time - self.minute*60
////            timeHandler(self.minute,self.second)
////            }
//        })
//        self.timer.fire()
//    }
    
    func makeAndFireTimer(timeHandler: @escaping (Date) -> Void) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[unowned self] (timer: Timer) in
            
            timeHandler(self.endTime)

        })
        self.timer.fire()
    }
    
    func invalidateTimer() {
        if timer != nil {
        self.timer.invalidate()
        self.timer = nil
        }
    }
}
