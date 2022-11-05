import UIKit
import Alamofire
import KeychainAccess

class EditViewController: UIViewController {
    
    private var token = ""
    var articleId: Int!
    let consts = Constants.shared
    let okAlert = OkAlert()
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = LoadToken().loadAccessToken()
        titleTextField.delegate = self
        let viewCustomize = ViewCustomize()
        //TextViewに枠線をつける
        bodyTextView = viewCustomize.addBoundsTextView(textView: bodyTextView)
        
        //imageViewに枠線をつける
        imageView = viewCustomize.addBoundsImageView(imageView: imageView)
        
        //記事のIDがnilじゃなければ記事を読み込む
        guard let id = articleId else { return }
        loadArticle(articleId: id)
    }
    
    //編集したい記事の情報をapiでリクエストして読み込む
    func loadArticle(articleId: Int) {
        guard let url = URL(string: consts.baseUrl + "/api/posts/\(articleId)") else { return }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        AF.request(
            url,
            headers: headers
        ).responseDecodable(of: Article.self) { response in
            switch response.result {
            case .success(let article):
                self.titleTextField.text = article.title
                self.bodyTextView.text = article.body
                self.imageView.kf.setImage(with: URL(string: article.imageUrl)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //画像がタップされたとき
    @IBAction func selectImage(_ sender: Any) {
        selectionAlert()
    }
    
    //カメラかアルバムか、選択されたほうを表示して画像を選択
    func selectionAlert(){
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.checkCamera()
        }
        
        let albamAction = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.checkAlbum()
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(albamAction)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    //カメラがあったら起動
    func checkCamera() {
        let sourceType:UIImagePickerController.SourceType = .camera
        let cameraPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true,completion: nil)
        }
    }
    
    //フォトライブラリがあったら起動
    func checkAlbum() {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        let cameraPicker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true,completion: nil)
        }
        
    }
    
    
    //更新のリクエスト(PATCH)
    func updateRequest(token: String, image: UIImage, articleId: Int) {
        
        //URLに記事のIDを含めることを忘れずに!
        guard let url = URL(string: consts.baseUrl + "/api/posts/\(articleId)") else { return }
        
        /*
         //ヘッダーの書き方はどちらでもOK
         let headers: HTTPHeaders = [
         "Accept": "application/json",
         "Authorization": "Bearer \(token)",
         "Content-Type": "multipart/form-data"
         ]
         */
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json"),
            .contentType("multipart/form-data")
        ]
        
        
        //文字情報と画像やファイルを送信するときは 「AF.upload(multipartFormData: …」 を使う
        AF.upload(
            multipartFormData: { multipartFormData in
                
                guard let imageData = image.jpegData(compressionQuality: 0.01) else {return}
                multipartFormData.append(imageData, withName: "image", fileName: "file.jpg")
                
                guard let titleTextData = self.titleTextField.text?.data(using: .utf8) else {return}
                multipartFormData.append(titleTextData, withName: "title")
                
                guard let bodyTextData = self.bodyTextView.text?.data(using: .utf8) else {return}
                multipartFormData.append(bodyTextData, withName: "body")
                
                guard let method = "patch".data(using: .utf8) else { return }
                multipartFormData.append(method, withName: "_method")
                
                
            },
            to: url,
            method: .post,
            headers: headers
        ).response { response in
            switch response.result {
            case .success:
                self.completionAlart(title: "更新完了!", message: "記事を更新しました")
            case .failure(let err):
                print(err)
                self.okAlert.showOkAlert(title: "エラー!", message: "\(err)", viewController: self)
            }
        }
    }
    
    //更新する時に確認をするアラート
    func updateAlert(token: String, image: UIImage, articleId: Int) {
        let alert = UIAlertController(title: "更新しますか?", message: "この記事を更新してもよろしいですか?", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "更新", style: .destructive) { action in
            self.updateRequest(token: token, image: image, articleId: articleId)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //削除リクエスト(DELETE)
    func deleteRequest(token: String, articleId: Int){
        guard let url = URL(string: consts.baseUrl + "/api/posts/\(articleId)") else { return }
        let headers :HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(
            url,
            method: .delete,
            headers: headers
        ).response { response in
            switch response.result {
            case .success:
                self.completionAlart(title: "削除完了", message: "記事を削除しました")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    //削除する時に確認をするアラート
    func deleteAlert(token: String, articleId: Int) {
        let alert = UIAlertController(title: "削除しますか?", message: "この記事を削除します", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "削除", style: .destructive) { action in
            self.deleteRequest(token: token, articleId: articleId)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //更新または削除処理完了の際のアラート。閉じると前の画面に戻る
    func completionAlart(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    //Update(更新)ボタン
    @IBAction func updateButton(_ sender: Any) {
        if titleTextField.text != "" && bodyTextView.text != "" && imageView.image != nil {
            guard let id = articleId else { return }
            updateAlert(token: token, image: imageView.image!, articleId: id)
        } else {
            okAlert.showOkAlert(title: "未入力欄があります", message: "全ての欄を入力してください", viewController: self)
        }
    }
    

    //Delete(削除)ボタン
    @IBAction func deleteButton(_ sender: Any) {
        guard let articleId = articleId else { return }
        deleteAlert(token: token, articleId: articleId)
    }
    
    //入力欄以外をタッチしたときにキーボードを下げる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    
}




// MARK: Delegate
    

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //画像の選択完了後の処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] as? UIImage != nil{
            let selectedImage = info[.originalImage] as! UIImage
            imageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    //画像の選択をキャンセルしたときの処理
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
