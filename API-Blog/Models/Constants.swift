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
//    let baseUrl = "http://localhost"
//    let oauthUrl  = "http://localhost/oauth/authorize"
//    let clientId = 4
//    let clientSecret = "HJrIGGNmLT0efyFw8ugWEyi7FFNx9QiADBRHNhUT"
    
//    let clientSecret = "9mjkXO8LlU8rApDhC5kmFCBGFJZNT3LZliDovH2X"
    
//    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiOTdhYjgzOGI5ZmE1MTEwNWYxNzcwN2Q1MmFhMDdiYTRkZTI4NGE0MDU5ZDgzNGE5MmFiN2IxZDJhYWU1YjFkODI1ZDAwMzJlZDQzODhlZTEiLCJpYXQiOjE2NjY3NjkwOTUuMDIxMjgzLCJuYmYiOjE2NjY3NjkwOTUuMDIxMjg1LCJleHAiOjE2OTgzMDUwOTUuMDA5NDU0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.BiOVQXsO3RB33SccmM8hLPk2jnWsQI3gjiVFxlbktUXeZJIdrRBxLfrZf3fqfT9UYe6wcsBPhStzx4aSLPtb8j2QJhbowFEtTBQrrEE7Parqrm-VnLuvuL1Wm_JO9dmgRlmvmDDizSCYKs7kPxIR9nPDZ7Ywu_dC4qFaqOCeq83BCW2hhybDcWX4T13xbGtS9Nn_y0zAD7zzvm8O8nylPQYJOn8TGpFG3vyxRTPwdI1itQo8cSBkqShHSMHMxmngc9vNTmUFHUT3gdu_SvyNBw9Qg2f9opDgmWTr5VOUZB4lvaRyE8R5JWF0vsImejoT7zYy1PiQZEIL_q7dhBc6bY680HXZdsXMPa06WdEW3fpgN5UF2iIX7XfeJjOi-64K1kg5ltXdO4B2uqaD0mzQ6CpbY9lYLeHaZiQvbzliP1xVmVcfeTf7_ww5prnrmLwIVXUr_FZpYCCOPIDB6PAZd8eUE2gqsQn4882hEfd1ycmM93aFdCnyn0gUFyY06sBi0eSP_is0gWdTb08FiMipJ-cIaykw_MTWiBtd-pvGA2TR4927RPc3v_JKc6vCfChplXQD_zyVqk_B1yfnCg1HUqKmYTQCwfTypzwVDisSVv5L8UBYqm2RBIsumI26Ep9US9B4lzA92Teg2bBRj15V0ApDCy3VLyebAaskkfq1xtg"
   
    
    /*
     Heroku Deployed
     */
    
    let baseUrl = "https://api-blog-20221026.herokuapp.com"
    let oauthUrl  = "https://api-blog-20221026.herokuapp.com/oauth/authorize"
    
        let clientId = "1"
        let clientSecret = "aXVBqa6AmcPOCZQIonDjCW4bJIeK5LO7yJR7Mp7s"
    
//    let clientId = "1"
//    let clientSecret = "aXVBqa6AmcPOCZQIonDjCW4bJIeK5LO7yJR7Mp7s"
    
    
    
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
 
 
 
 "client_id": "1",
 "client_secret": "aXVBqa6AmcPOCZQIonDjCW4bJIeK5LO7yJR7Mp7s",
 
 
 
 自分のアプリで作成
 Client ID: 3
 Client secret: aAXvCB66vPDBTCqhDQrR2xdcB7FkWOG9rrU1mSCv
 
 url scheme = "api-blog-oauth"
 
 
 
 
 CODE:
 
 def502008d9c3f48284f25669e51f77bb77eb599e2ec28c9f92393707579da290b9eb6ff8960c04616a1e3c1000ca3ee38afc6d9758d51722c8a197720e27874bfe1a166171a5d59d3d15fa2437fd4d0c3afad920288ecc84c957491263650a60afaf0cb9f05c413e24f3ca0a5863cf556b286554eb50460dff0cc36566d2c3539b45781fbf44c7126fdfd5380ab84336b573425281536452385e107dfd368c279df29d6eb4dd195513e1d33db163af4c8e80af28bed2a4dcaf893bf6b8643bb33ea7c0730278a919bf7c4736d7af3e8caa7c33a19b743373faac96955b2f278dc8ea26a2a0efa9146c45faf07c5733634981b378a10a57fa646337f8467fafa9c04b68d314f381d3f2f09340583764947c56b4e70071024656a6d97bbf29d25a59209de5095f0cc295795a8bad6d57595fafa20220cd49893090e9783e85a17
 */
