//
//  ViewController.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/10/30.
//


/*
 
 MARK: OAuth2
 
code取得までは可能、しかし
 
 
 {
  "error_description" : "Client authentication failed",
  "error" : "invalid_client",
  "message" : "Client authentication failed"
 }
 
 となる
 */

import UIKit
import Alamofire
import KeychainAccess
import AuthenticationServices
import SwiftyJSON

class LoginViewController: UIViewController {
    let consts = Constants.shared
    var session: ASWebAuthenticationSession? //Webの認証セッションを入れておく変数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let url = URL(string: consts.oauthUrl + "?client_id=\(consts.clientId)&response_type=code&scope=") else { return }
        session = ASWebAuthenticationSession(url: url, callbackURLScheme: consts.callbackUrlScheme) {(callback, error) in
            guard error == nil, let successURL = callback else {
                print(error)
                return
            }
            let queryItems = URLComponents(string: successURL.absoluteString)?.queryItems
            
            print("🔥QUERY ITEMS🔥:\n", queryItems)
            guard let code = queryItems?.filter({ $0.name == "code" }).first?.value else { return }
            
            print("🌟CODE🌟:\n", code)
            
            self.getAccessToken(code: code)
        }
        session?.presentationContextProvider = self //デリゲートを設定
        session?.prefersEphemeralWebBrowserSession = true //認証セッションと通常のブラウザで閲覧情報やCookieを共有しないように設定。
        session?.start()  //セッションの開始(これがないと認証できない)
    }
    // gorilla@gorilla.com
    
    func getAccessToken(code: String!) {
        let url = URL(string: consts.baseUrl + "/oauth/token")!
        guard let code = code else { return }
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/x-www-form-urlencoded",
//        ]
        let parameters: Parameters = [
            "grant_type": "authorization_code",
            "client_id": consts.clientId,
            "client_secret": consts.clientSecret,
            "code": code,
            "redirect_uri": consts.callbackUrlScheme
        ]
        
        /*
        //Alamofireでリクエスト
          AF.request(
            url,
            method: .post,
            parameters: parameters//,
//            encoding: JSONEncoding.default,
//            headers: headers
          ).responseDecodable(of: GetToken.self) { response in
              switch response.result {
              case .success(let value):
                 let token = value.accessToken
                  print("🌟TOKEN🌟:\n", token)
              case .failure(let err):
                  print(err)
              }
          }
      }
         */
    
    AF.request(
            url,
            method: .post,
            parameters: parameters
//            encoding: JSONEncoding.default,
//            headers: headers
          ).response { response in
              switch response.result {
              case .success:
                  print("🍏RESPONSE🍎\n",JSON(response.data))
              case .failure(let err):
                  print(err)
              }
          }
      }
    
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
}

/*
 {
 "error":"unsupported_grant_type",
 "error_description":"The authorization grant type is not supported by the authorization server.",
 "hint":"Check that all required parameters have been provided",
 "message":"The authorization grant type is not supported by the authorization server."
 
 }
 */
