//
//  ProjectSetting.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/08/08.
//  Copyright © 2020 Team STORM. All rights reserved.
//

enum Mode {
    case host
    case member
}

class ProjectSetting {
    static let shared = ProjectSetting()
    
    var mode: Mode = .host
    var projectIdx: Int?
    var projectCode: String?
    var roundNumb: Int?
    var roundIdx: Int?
    var roundTime: Double = 0
    var roundPurpose: String = ""
    var projectName: String = ""
    var isAdded: Bool = false
}
