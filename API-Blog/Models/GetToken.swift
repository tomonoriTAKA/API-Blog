//
//  GetToken.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/03.
//

import Foundation

struct GetToken: Codable {
    let accessToken: String?

    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
}
