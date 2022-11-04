//
//  Constants.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/01.
//

import Foundation

struct Constants {
    static let shared = Constants()
    private init() {}
    let articleCellReuseId =  "ArticleCell"
    let commentCellReuseId = "CommentCell"
    
 /* localhost */
    let baseUrl = "http://localhost"
    let oauthUrl  = "http://localhost/oauth/authorize"
    let clientId = 5
    let clientSecret = "0FW3055UO0FmFX7VSTtanSJe0zrsvhDUazrrVvtC"
    
    let token =  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI3IiwianRpIjoiNWZmODQ2YWIzNTE0MDc4MWIzNzVlMDhlYjNjYjMzNDZlZTg3ZmMxZmRkY2IzZjE1MjFiNzg0NDAzNTMwOGI3OWJlNDRkOGI4OTliZjhmMTQiLCJpYXQiOjE2Njc1NjUzODkuMTc1Mzk4LCJuYmYiOjE2Njc1NjUzODkuMTc1NDAxLCJleHAiOjE2OTkxMDEzODkuMTcxMzAyLCJzdWIiOiIiLCJzY29wZXMiOltdfQ.U7CnY_yHH18tvUSYKur2x3t_wEifyXoTFOn9_S6s68hHiX-v9DTN_cPfl7sIGyYNszQ-3ihhfBbh10EsEUcArZPDTc1IXI6xRIQPVVgsGHq2UPyOIraWreYzy7E1pzb6nB410y3b7HqurNfC2__R3gg44iPYAgXUKFTZ35jmRHSrK9ja4iyhTLs0GeH_7N817m81PEpWBM2N3olxWQvkRPdCn6cOwj3JKg5DNc3gYkbRVlXQffeVFhESNQAHpdPRgqb0uvkZx_xlhb_aTAaW5gtkmE05wpE6u44sToFTa1yh6yyUGh4x3D9U_AwOzQVyKrXIEbiGQwPCH9P1v8E4ZPSb4U4axIOYz358HeJBT5PhI72UXManNqsXau0cjBMQFFp3h-_aGCvKpi8iWP6fE8GuilgzDzHeXEwWmp40PUXzU2LVwcfDN0VK2c9_x-_3y3zK6ZY0QCWvbEaF6CPHjxcmOXfAQCRCi0gVmXGyQ9y-nTJuX9CZMzqbPu26b2mgfrEiV9zHgjXSG408N_IOV88bG5CZo5BnPIyL805PIOWXDFalE0Lq3VzCY7yDssX3rOnjGV0S8aWXOWoEk6fJMDI-TBoh62xwEYW9Gagr8QD3Hm2WRHsh1mfloCthBneT9YjIfIEu5ekOwcZzm5_-fZnXQUnEmPfdwtKoJLtikn4"
    /*
     Heroku Deployed
     */
    
//    let baseUrl = "https://api-blog-20221026.herokuapp.com"
//    let oauthUrl  = "https://api-blog-20221026.herokuapp.com/oauth/authorize"
//
//    let clientId = 1
//    let clientSecret = "aXVBqa6AmcPOCZQIonDjCW4bJIeK5LO7yJR7Mp7s"
//    let clientId = 7
    
    let callbackUrlScheme = "api-blog-oauth"
    let service = "api-blog"
    let redirectUri = "api-blog-oauth://callback"
}

/*
 
 | API内容      | Method URL                               |
 | ------------ | ---------------------------------------- |
 | OAuth認証    | GET oauth/authorization                  |
 | Token発行    | POST oauth/token                         |
 | 詳細         | GET api/posts/{post}                     |
 | 一覧         | GET api/posts                            |
 | 投稿         | POST api/posts                           |
 | 更新         | PUT/PATCH api/posts/{post}               |
 | 削除         | DELETE api/posts/{post}                  |
 | コメント投稿 | POST api/posts/{post}/comments           |
 | コメント削除 | POST api/posts/{post}/comments/{comment} |

 */
