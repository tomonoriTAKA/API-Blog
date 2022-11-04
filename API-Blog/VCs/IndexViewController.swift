//
//  IndexViewController.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/01.
//
import SwiftyJSON

import UIKit
import Alamofire
import Kingfisher
import KeychainAccess

class IndexViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    let consts = Constants.shared
    private var token = ""
    let sectionTitle = ["投稿一覧"]
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.dataSource = self
        articleTableView.delegate = self
//        token = consts.token
//        if let token = Keychain(service: consts.service)["access_token"] {
//            print(token)
//        }
        getUser()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        requestIndex()
    }
    
    func requestIndex(){
        let url = URL(string: consts.baseUrl + "/api/posts")!
        let token = LoadToken().loadAccessToken()
//        print("TOKEN:", token)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(token)",
        ]
        
        AF.request(
            url,
            headers: headers
        ).responseDecodable(of: Index.self) { response in
            switch response.result {
            case .success(let articles):
//                print(response.result)
                print("🔥success from Index🔥")
                if let atcls = articles.data {
                    self.articles = atcls
                    self.articleTableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
//
//        AF.request(
//            url,
//            headers: headers
//        ).response { response in
//            switch response.result {
//            case .success(let data):
////                print("🌟JSON:🌟\n", JSON(data))
//            case .failure(let err):
//                print(err)
//            }
//        }
    }
    
    
    func getUser() {
        let url = URL(string: consts.baseUrl + "/api/user")!
        let token = LoadToken().loadAccessToken()
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json")
        ]
        
        AF.request(
            url,
            headers: headers
        ).response { response in
            switch response.result {
            case .success(let data):
                print("🐳From getUser🐳", JSON(data))
            case .failure(let err):
                print(err)
            }
        }
        
    }
}
    

extension IndexViewController: UITableViewDataSource {
    
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //セクションの数 (= セクションのタイトルの数)
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    //行の数(= 記事の数)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    //セル1つの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: consts.articleCellReuseId, for: indexPath) as! ArticleTableViewCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.authorLabel.text = articles[indexPath.row].userName
        cell.createdAtLabel.text = articles[indexPath.row].createdAt
        cell.articleImageView.kf.setImage(with: URL(string: articles[indexPath.row].imageUrl)!)
        cell.bodyLabel.text = articles[indexPath.row].body
        
        return cell
    }
    
}

extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailVC.articleId = article.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
