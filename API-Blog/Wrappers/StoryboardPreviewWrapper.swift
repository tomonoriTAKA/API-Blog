import UIKit
import SwiftUI

struct StoryboardPreviewWrapper:UIViewControllerRepresentable {
    
    let previewStoryboard:String = "Main"
    let previewId:String
    var setValue:(UIViewController)->Void = {_ in }

    
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: self.previewStoryboard, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: self.previewId)
        self.setValue(controller)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
}


// MARK:   Write Bottom VC and Replace Storyboard ID
/**
 
 
 
 
 struct ViewController_Preview:PreviewProvider {
     static var previews: some View{
         StoryboardPreviewWrapper(previewId: "YOUR_STORYBOARD_ID", setValue: { controller in
             let viewController = controller as! ViewController
             viewController.labelText = "Preview"
         })
     }
 }
 
 
 
 **/
