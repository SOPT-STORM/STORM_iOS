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
    let data: [Project]
}
