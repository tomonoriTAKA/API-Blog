//
//  CreateViewController.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/01.
//

import SwiftyJSON

import UIKit
import Alamofire
import KeychainAccess
import FirebaseStorage


class CreateViewController: UIViewController {
    let consts = Constants.shared
    let okAlert = OkAlert()
    
    
//    var imageUrlStr = "" //画像URLの文字列を入れる変数
    var imageUrlStr = "https://firebasestorage.googleapis.com/v0/b/hare-blog-20536.appspot.com/o/images%2Fposts%2FTCyJqpUNGTuKbVu0s0.jpg?alt=media&token=e139a55a-3161-40bd-b523-33143177b620" //画像URLの文字列を入れる変数
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //画像がタップされたとき
    @IBAction func selectImage(_ sender: Any) {
        selectionAlert()
    }
    
    //投稿ボタン
    @IBAction func postArticle(_ sender: Any) {
        if titleTextField.text != "" && bodyTextView.text != "" && imageView.image != nil {
//            postImage(image: imageView.image!)
            createRequest(token: self.consts.token, imageUrlStr: imageUrlStr)
            okAlert.showOkAlert(title: "作成完了", message: "記事が作成されました", viewController: self)
//                self.navigationController?.popViewController(animated: true)
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
    func createRequest(token: String, imageUrlStr: String) {
        guard let url = URL(string: consts.baseUrl + "/api/posts") else { return }
        if imageUrlStr == "" {
            okAlert.showOkAlert(title: "画像のURLがありません", message: "画像のURLがないので保存できません", viewController: self)
            return
        }
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        let parameters: Parameters = [
            "title": titleTextField.text!,
            "body": bodyTextView.text!,
            "image_url": imageUrlStr,
            "user_id": 3 //  🌟1回具体的に入れてみる🌟
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            headers: headers
        ).response { response in
            switch response.result {
            case .success(let data):
                print("🌟DATA🌟:\n", JSON(data))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func postImage(image: UIImage) {
        var urlStr = ""
        //ストレージサーバーのURLを取得
        let storage = Storage.storage().reference(forURL: consts.storageUrlStr)
        
        //画像保存用フォルダの指定(無ければ作成される)
        let imageRef = storage.child("images/posts").child("\(RandomString().generator(25)).jpg")
        
        //画像があったら用意した変数（データ型）にサイズ1/200でいれる
        guard let imageData: Data = (image.jpegData(compressionQuality: 0.005)) else { return }
        
        //アップロード
        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
            imageRef.downloadURL { url, error in
                if let url = url {
                    self.imageUrlStr = url.absoluteString
                }
            }
        }
        
        uploadTask.resume()
    }
}
    

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //画像の選択完了後の処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] as? UIImage != nil{
            let selectedImage = info[.originalImage] as! UIImage
            imageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
//            postImage(image: selectedImage)
        }
    }
    
    //画像の選択をキャンセルしたときの処理
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//extension CreateViewController: UINavigationControllerDelegate {
//
//}
