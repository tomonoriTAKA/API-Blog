//
//  RandomString.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/04.
//

import Foundation
struct RandomString {
    func generator(_ length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 0 ..< length {
            randomString += String(letters.randomElement()!)
        }
        return randomString
    }
}

