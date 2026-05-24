//
//  PostDetailViewController.swift
//  instagram2
//

import UIKit

@MainActor
class PostDetailViewController: UIViewController {
    var post: InstaPost?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.username
    }
}
