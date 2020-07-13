//
//  User.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct User: Codable{
    let user_name: String
    let user_token_google: String?
    let user_token_kakao: String?
    let user_img: String
    let user_idx: Int?
}
