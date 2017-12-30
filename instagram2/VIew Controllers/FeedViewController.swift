//
//  FeedViewController.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/25/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse
class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
  var instaFeed: [PFObject] = []

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 180
        // Do any additional setup after loading the view.
    
   
    self.view.isUserInteractionEnabled = true
   // let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
     //posterImageView.addGestureRecognizer(tapRecognizer)
    }
  
  
/*  func imageTapped(gestureRecognizer: UITapGestureRecognizer)
  {
    let tappedImageView = gestureRecognizer.view!
    let posterImageView = tappedImageView as! UIImageView
  }*/
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    let query = PFQuery(className: "Post")
    query.order(byDescending: "createdAt")
    query.limit = 20
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
      if let posts = posts{
        self.instaFeed = posts
        self.tableView.reloadData()
      } else {
        print(error?.localizedDescription)
      }
    }
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return instaFeed.count
  }
  
  @objc func didTap(sender: UITapGestureRecognizer) {
    let location = sender.location(in: view)
    // User tapped at the point above. Do something with that if you want.
    performSegue(withIdentifier: "tapSegue", sender: self)
  }
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! InstaPostCell
    let post = instaFeed[indexPath.row]
    let photo = post["media"] as! PFFile
    // The didTap: method will be defined in Step 3 below.
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
    
    // Optionally set the number of required taps, e.g., 2 for a double click
    tapGestureRecognizer.numberOfTapsRequired = 1
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    cell.photoImageView.isUserInteractionEnabled = true
    cell.photoImageView.addGestureRecognizer(tapGestureRecognizer)
    photo.getDataInBackground { (
      data: Data?,
      error: Error?) in
      if let data = data {
        cell.photoImageView.image = UIImage(data: data)
      }
    }
    cell.capLabel.text = post["caption"] as! String?
    return cell
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    
    let vc = PostDetailViewController()
    let post = instaFeed[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! InstaPostCell

    vc.captionLabel.text = post["caption"] as? String
    vc.dateLabel.text = post["timestamp"] as? String
    vc.photoImageView.image = cell.photoImageView.image
    present(vc, animated: true) {
      print("presented")
    }
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
