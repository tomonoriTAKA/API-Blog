//
//  CreateViewController.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/01.
//

import UIKit
import Alamofire
import KeychainAccess


class CreateViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func postArticle(_ sender: Any) {
    }
    

}
