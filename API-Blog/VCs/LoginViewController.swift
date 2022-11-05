//
//  ViewController.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/10/30.
//

import SwiftyJSON

import UIKit
import Alamofire
import KeychainAccess
import AuthenticationServices

class LoginViewController: UIViewController {
    let consts = Constants.shared
    var session: ASWebAuthenticationSession? //Webの認証セッションを入れておく変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let token = LoadToken().loadAccessToken()
//        print("TOKEN:",token)
//        let keychain = Keychain(service: consts.service)
//        keychain["access_token"] = nil
    }
    
    //ログインボタンを押した時の処理
    @IBAction func login(_ sender: Any) {
        let keychain = Keychain(service: consts.service)
        if keychain["access_token"] != nil { //アクセストークンが既に取得できているときの処理
            transitionToIndex()
        } else {
            guard let url = URL(string: consts.oauthUrl + "?client_id=\(consts.clientId)&response_type=code&scope=") else { return }
            session = ASWebAuthenticationSession(url: url, callbackURLScheme: consts.callbackUrlScheme) {(callback, error) in
                guard error == nil, let successURL = callback else { return }
                let queryItems = URLComponents(string: successURL.absoluteString)?.queryItems
                guard let code = queryItems?.filter({ $0.name == "code" }).first?.value else { return }
                self.getAccessToken(code: code)
            }
        }
        session?.presentationContextProvider = self //デリゲートを設定
        session?.prefersEphemeralWebBrowserSession = true //認証セッションと通常のブラウザで閲覧情報やCookieを共有しないように設定。
        session?.start()  //セッションの開始(これがないと認証できない)
    }
    
    func getAccessToken(code: String) {
        //オプショナルバインディングでアンラップ
        guard let url = URL(string: consts.baseUrl + "/oauth/token") else { return }
        
        let parameters: Parameters = [
            "grant_type": "authorization_code",
            "client_id": consts.clientId,
            "client_secret": consts.clientSecret,
            "code": code//,
//            "redirect_uri": consts.redirectUri
        ]
        
        
        //Alamofireでリクエスト
        AF.request(
            url,
            method: .post,
            parameters: parameters
        ).responseDecodable(of: GetToken.self) { response in
            switch response.result {
            case .success(let value):
                let token = value.accessToken
                let keychain = Keychain(service: self.consts.service) //このアプリ用のキーチェーンを生成
                keychain["access_token"] = token //トークンをキーチェーンに保存
                print("🌟TOKEN🌟:\n", token)
                self.transitionToIndex()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func transitionToIndex() {
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
}
