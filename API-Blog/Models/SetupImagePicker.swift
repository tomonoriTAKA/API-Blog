//
//  SetupImagePicker.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/04.
//


import UIKit

class SetupImagePicker: UIImagePickerController {
    
    func checkCamera() -> UIImagePickerController {
        let sourceType:UIImagePickerController.SourceType = .camera
        let cameraPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.present(cameraPicker, animated: true,completion: nil)
        }
        return cameraPicker
    }
    
    
    func checkAlbum() -> UIImagePickerController  {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        let cameraPicker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.present(cameraPicker, animated: true,completion: nil)
        }
        
        return cameraPicker
    }
    
}
