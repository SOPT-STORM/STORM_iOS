//
//  Card.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct Card: Codable {
    let card_idx: Int?
    let card_img: String?
    let card_txt: String?
}

struct CardWithMemo: Codable {
    let user_idx: Int
    let card_idx: Int
    let memo_content: String
}
