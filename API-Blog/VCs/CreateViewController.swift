import UIKit
import Alamofire
import KeychainAccess

class CreateViewController: UIViewController {
    
    private var token = ""
    let consts = Constants.shared
    let okAlert = OkAlert()
    var user: User!
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
        
        
    }
    
    //画像がタップされたとき
    @IBAction func selectImage(_ sender: Any) {
        selectionAlert()
    }
    
    //投稿ボタン
    @IBAction func postArticle(_ sender: Any) {
        if titleTextField.text != "" && bodyTextView.text != "" && imageView.image != nil {
            createRequest(token: token, image: imageView.image!)
        } else {
            okAlert.showOkAlert(title: "未入力欄があります", message: "全ての欄を入力してください", viewController: self)
        }
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
    
    
    //投稿のリクエスト
    func createRequest(token: String, image: UIImage) {
        guard let url = URL(string: consts.baseUrl + "/api/posts") else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.01) else {return}
        
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
                multipartFormData.append(imageData, withName: "image", fileName: "file.jpg")
                
                guard let titleTextData = self.titleTextField.text?.data(using: .utf8) else {return}
                multipartFormData.append(titleTextData, withName: "title")
                
                guard let bodyTextData = self.bodyTextView.text?.data(using: .utf8) else {return}
                multipartFormData.append(bodyTextData, withName: "body")
                
                guard let user = self.user else { return }
                guard let userIdData = String(user.id).data(using: .utf8) else {return}
                multipartFormData.append(userIdData, withName: "user_id")
                
            },
            to: url,
            method: .post,
            headers: headers
        ).response { response in
            switch response.result {
            case .success(let data):
//                print("🍏success from Create🍏", JSON(data))
                self.createAlart(title: "投稿完了!", message: "作成した記事を投稿しました")
            case .failure(let err):
                print(err)
                self.okAlert.showOkAlert(title: "エラー!", message: "\(err)", viewController: self)
            }
        }
    }
    
    func createAlart(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
}
    

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
