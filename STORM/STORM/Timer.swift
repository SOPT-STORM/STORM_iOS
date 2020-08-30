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
    var endTime = Date()
    
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
