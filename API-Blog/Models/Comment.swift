//
//  Comment.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/03.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let body: String
    let userId: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case body
        case userId = "user_id"
        case createdAt = "created_at"
    }
}
