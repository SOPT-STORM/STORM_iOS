//
//  User.swift
//  STORM
//
//  Created by 김지현 on 2020/08/19.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct User: Codable {
    let user_idx: Int
    let user_img: String
    let user_name: String
    let user_email: String
    let user_password: String
    let user_img_flag: Int
}

struct Login: Codable {
    let user_email: String
    let user_password: String
}

struct ConfirmPwd: Codable {
    let user_idx: Int
    let user_password: String
}

struct UserImage: Codable {
    let user_idx: Int
    let user_img: String
    let user_img_flag: Int
}

struct UserName: Codable {
    let user_idx: Int
    let user_name: String
}


struct MyPage: Codable {
    let user_img: String
    let user_name: String
    let user_img_flag: Int
}

struct WithDrawal: Codable {
    let user_idx : Int
    let user_password : String
    let reason : String
}




