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
    var article: Article! //Indexの画面から受け取る
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
        guard let atcl = article else { return } //記事のnilチェック
        
        //記事にコメントがあるかチェック
        if let cmnts = atcl.comments {
            comments = cmnts
        }
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
        cell.commentAuthorLabel.text = comments[indexPath.row].userName
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
