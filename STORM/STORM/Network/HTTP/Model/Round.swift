//
//  Round.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct Round: Codable {
    let project_idx: Int
    let round_purpose: String
    let round_time: Int
    let user_idx: Int
}

struct RoundInfo: Codable {
    let round_idx: Int?
    let round_number: Int?
    let round_purpose: String?
    let round_time: Int?
    let round_participant: [Member]?
}

struct RoundWithMemberIdx: Codable {
    let user_idx: Int
    let project_idx: Int
}
