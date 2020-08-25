//
//  Member.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct Member: Codable {
    let user_idx: Int?
    let user_name: String
    let user_img: String
    let user_host_flag: Int? // Host = 1, member = 0
}
