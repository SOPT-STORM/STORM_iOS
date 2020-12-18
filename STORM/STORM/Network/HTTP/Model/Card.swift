//
//  Card.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/14.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

struct Card: Codable {
    let card_idx: Int?
    var scrap_flag: Int?
    let card_img: String?
    let card_txt: String?
    let user_img: String?
    let user_idx: Int?
    let memo_content: String?
}

struct CardWithMemo: Codable {
    let user_idx: Int
    let card_idx: Int
    let memo_content: String?
}

struct addedCard {
    let card_drawing: UIImage?
    let card_text: String?
}

struct scrappedCard: Codable {
    let round_number: Int
    let round_purpose: String
    let round_time: Int
    let user_img: String
    let card_idx: Int
    let card_img: String?
    let card_txt: String?
    let memo_content: String?
}

struct CardItem: Codable {
    let round_number: Int
    let round_purpose: String
    let round_time: Int
    let user_img: String?
    let card_idx: Int
    let card_img: String?
    let card_txt: String?
    let memo_content: String?
}
