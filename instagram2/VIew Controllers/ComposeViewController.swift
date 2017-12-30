//
//  ComposeViewController.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/25/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var captionTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let vc = UIImagePickerController()
      vc.delegate = self
      vc.allowsEditing = true
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        print("Camera is available 📸")
        vc.sourceType = .camera
      } else {
        print("Camera 🚫 available so we will use photo library instead")
        vc.sourceType = .photoLibrary
      }
      self.present(vc, animated: true, completion: nil)
      
        // Do any additional setup after loading the view.
    }
  
  
  
  @IBAction func onCancelButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)

  }
  
  @IBAction func onShareButton(_ sender: Any) {
    let imagePost = resize(image: self.posterImageView.image!, newSize: CGSize(width: 600, height: 600))
    let caption = self.captionTextField.text
    Post.postUserImage(image: imagePost, withCaption: caption) { (
      success: Bool,
      error: Error?) in
      if success {
        self.tabBarController?.selectedIndex = 0
        self.dismiss(animated: true, completion: nil)
      } else {
        print(error?.localizedDescription)
      }
  }
  }
  func resize(image: UIImage, newSize: CGSize) -> UIImage {
    let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
    resizeImageView.image = image
    
    UIGraphicsBeginImageContext(resizeImageView.frame.size)
    resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
  
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    // Get the image captured by the UIImagePickerController
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    self.posterImageView.image = originalImage
    // Do something with the images (based on your use case)
   // self.performSegue(withIdentifier: "goBackSegue", sender: self)

    // Dismiss UIImagePickerController to go back to your original view controller
    dismiss(animated: true, completion: nil)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
