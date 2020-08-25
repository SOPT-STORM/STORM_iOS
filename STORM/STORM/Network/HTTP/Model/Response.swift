//
//  Response.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/12.
//  Copyright © 2020 Team STORM. All rights reserved.
//

struct Response: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ProjectWithDetail]?
}

struct MemberResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [Member]?
}

struct RoundResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: RoundInfo?
}

struct RoundFinalResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [RoundInfo]?
}

struct CardResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ProjectInfo?
}

struct ProjectResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: FinalProjectInfo
}

struct ProjectIdxResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ProjectWithIdx?
}

struct ProjectInfoResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Project?
}

struct IntegerResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Int?
}

struct ScrappedCardResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ProjectWithScrap
}

struct LogInResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Int?
}

struct SignUpResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Int?
}

struct MyPageResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: MyPage?
}

struct ConfirmResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
}

struct WithdrawalResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
}

struct ModifyResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
}
