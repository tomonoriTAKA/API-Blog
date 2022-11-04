//
//  DetailViewController.swift
//  API-Blog
//
//  一覧画面で記事と一緒にコメントも取ってきているので、ここでは記事取得のリクエストはしない

import SwiftyJSON

import UIKit
import Alamofire
import KeychainAccess

class DetailViewController: UIViewController {
    let consts = Constants.shared
    var articleId: Int! //Indexの画面から受け取る
    var article: Article?
    var comments: [Comment] = []
    let commentSectionName = ["コメント一覧"]
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var commentTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let id = articleId else { return } //記事のnilチェック
        print("ID: ",id)
        getArticleWithComments(id: id)
    }
    
    
    //idから記事と一緒にコメントを取得
    func getArticleWithComments(id: Int) {
        guard let url = URL(string: consts.baseUrl + "/api/posts/\(id)") else { return }
        print(url)
        
        // トークン必要、あとでheaderに含める
        let token = consts.token
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(
            url,
            headers: headers
        ).responseDecodable(of: Article.self) { response in
            switch response.result {
            case .success(let article):
                self.article = article
                self.titleLabel.text = article.title
                self.authorLabel.text = article.userName
                self.createdAtLabel.text = article.createdAt
                self.bodyLabel.text = article.body
                self.articleImageView.kf.setImage(with: URL(string: article.imageUrl)!)
                guard let comments = article.comments else { return }
                self.comments = comments
                self.commentTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        
//        AF.request(url, headers: headers).response { response in
//            switch response.result {
//            case .success(let data):
//                print(JSON(data))
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    
    
    
    
}


extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentSectionName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return commentSectionName[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: consts.commentCellReuseId) as! CommentTableViewCell
        cell.commentLabel.text = comments[indexPath.row].body
//        cell.commentAuthorLabel.text = comments[indexPath.row].userName
        return cell
    }
    
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            comments.remove(at: indexPath.row)
            
            
            /*
             
             ここにコメントを削除する処理(確認アラートも含めて)
             
            */
            
            //tableViewを更新
            tableView.reloadData()
        }
    }
    
    
    // コメントのセルがタップされたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         
         編集画面に遷移させる処理!(元のコメントの情報をつけて)
         
         
         */
    }
}
