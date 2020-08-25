//
//  Project.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/13.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct Project: Codable {
    let project_name: String
    let project_comment: String?
    let user_idx: Int?
    let project_idx: Int?
    let project_code: String?
}

struct ProjectWithDetail: Codable {
    let project_idx: Int
    let project_name: String
    let card_list: [Card]
}

struct ProjectWithCode: Codable {
    let user_idx: Int
    let project_idx: Int
}

struct ProjectInfo: Codable {
    let project_name: String
    let round_number: Int
    let round_purpose: String
    let round_time: Int
    let card_list: [Card]
}

struct FinalProjectInfo: Codable {
    let project_name: String
    let project_date: String
    let round_count: Int
    let project_participants_list: [String]
}

struct ProjectWithIdx: Codable {
    let project_idx : Int
    let project_code : String?
}

struct ProjectWithScrap: Codable {
    let project_name: String
    let scrap_count: Int
    let card_item: [scrappedCard]
}
