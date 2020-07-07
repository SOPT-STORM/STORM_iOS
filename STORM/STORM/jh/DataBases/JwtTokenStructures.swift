//
//  JwtTokenStructures.swift
//  STORM
//
//  Created by 김지현 on 2020/07/07.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import Foundation

// Functions에 UID를 보낼 때 필요한 구조체
struct TokenInfo:Encodable {
    let uid:String
}

// JWT 토큰을 받을 때 필요한 구조체
struct JWT:Codable {
    let error:Bool? // ? -> 있을 수도 있고 없을 수도 있다, 받아올 모든 정보에 대해 ?로
    let jwt:String?
    let msg:String?
    let uid:String?
}
