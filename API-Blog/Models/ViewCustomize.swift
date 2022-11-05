//
//  ImageViewCustomize.swift
//  API-Blog
//
//  Created by 高橋知憲 on 2022/11/05.
//

import UIKit

struct ViewCustomize {
    func addBoundsImageView(imageView: UIImageView) -> UIImageView {
        imageView.layer.borderColor =  UIColor.placeholderText.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        return imageView
    }
    
    func addBoundsTextView(textView: UITextView) -> UITextView {
        textView.layer.borderColor =  UIColor.placeholderText.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5.0
        textView.layer.masksToBounds = true
        return textView
    }
    
}
