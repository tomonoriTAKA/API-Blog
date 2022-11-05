//
//  DetailViewController.swift
//  API-Blog
//
//  一覧画面で記事と一緒にコメントも取ってきているので、ここでは記事取得のリクエストはしない

import UIKit
import Alamofire
import KeychainAccess

class DetailViewController: UIViewController {
    let consts = Constants.shared
    let commentSectionName = ["コメント一覧"]
    private var token = ""
    var articleId: Int! //Indexの画面から受け取る
    var myUser: User!
    var comments: [Comment] = []
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var editAndDeleteButtonState: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        token = LoadToken().loadAccessToken()
        editAndDeleteButtonState.isEnabled = false
        editAndDeleteButtonState.tintColor = UIColor.clear
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = articleId {
            getArticleWithComments(id: id)
        }
        
        if let user = myUser {
            
        }

    }
    
    //idから記事と一緒にコメントを取得
    func getArticleWithComments(id: Int) {
        guard let url = URL(string: consts.baseUrl + "/api/posts/\(id)") else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(
            url,
            headers: headers
        ).responseDecodable(of: Article.self) { response in
            switch response.result {
            case .success(let article):
                print("🌟success from Detail🌟")
                self.titleLabel.text = article.title
                self.authorLabel.text = article.userName
                self.createdAtLabel.text = article.createdAt
                self.bodyLabel.text = article.body
                self.articleImageView.kf.setImage(with: URL(string: article.imageUrl)!)
                guard let comments = article.comments else { return }
                self.comments = comments
                self.commentTableView.reloadData()
                if let user = self.myUser {
                    if user.name == article.userName {
                        self.editAndDeleteButtonState.isEnabled = true
                        self.editAndDeleteButtonState.tintColor = UIColor.systemBlue
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func editOrDeleteButton(_ sender: Any) {
        guard let articleId = articleId else { return }
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "Edit") as! EditViewController
        editVC.articleId = articleId
        navigationController?.pushViewController(editVC, animated: true)
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
    // コメントのセルがタップされたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         
         コメントの編集画面に遷移させる処理!(元のコメントの情報をつけて) -> そこでコメント編集または削除
         
         
         */
    }
}
