//
//  Project.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct Project: Codable {
    let project_idx: Int
    let project_name: String
    let project_card: [String]
}

struct ProjectWithCode: Codable {
    let user_idx: Int
    let project_code: String
}
