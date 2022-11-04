//
//  LoadToken.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/03.
//

import Foundation
import KeychainAccess

struct LoadToken {
    func loadAccessToken() -> String {
        let keychain = Keychain(service: Constants.shared.service)
        guard let accessToken = keychain["access_token"] else { return "" }
        return accessToken
    }
}


