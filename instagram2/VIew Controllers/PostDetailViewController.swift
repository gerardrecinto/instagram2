//
//  PostDetailViewController.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/28/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse
class PostDetailViewController: UIViewController {

  @IBOutlet weak var captionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  var photo: UIImage!

  var post: PFObject?

  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.photoImageView.image = photo;
    captionLabel.text = post?["caption"] as? String
    let date = post?["timestamp"] as? Date
    if date != nil {
      dateLabel.text =
        date?.description(with: nil)//date?.toString(dateFormat: "MM-dd-yyy hh:mm")
    } else {
      dateLabel.text = "No date info"
    }
    
    
    
    if let postImage = post?["media"] as? PFFile {
      postImage.getDataInBackground(block: { (imageData: Data?, error: Error?) in
        if let imageData = imageData {
          self.photoImageView.image = UIImage.init(data: imageData)
        }
      })
    }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
