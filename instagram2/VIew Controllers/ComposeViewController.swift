//
//  ComposeViewController.swift
//  instagram2
//

import UIKit

@MainActor
class ComposeViewController: UIViewController {

    @IBOutlet weak var captionField: UITextField!

    @IBAction func onSubmit(_ sender: Any) {
        let caption = captionField?.text ?? ""
        guard !caption.isEmpty else { return }
        LocalInstagramService.shared.addPost(caption: caption)
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
