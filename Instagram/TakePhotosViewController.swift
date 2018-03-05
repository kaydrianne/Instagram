//
//  TakePhotosViewController.swift
//  Instagram
//
//  Created by TiAuna Dodd on 3/4/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit

class TakePhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController

        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        photoView.image = editedImage

        
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButton(_ sender: Any) {
    
        Post.postUserImage(image: photoView.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            if success{
                print("success")
                
            }else{
                print("unsuccessful")
            }
        }
    
    }
}
