//
//  LoginViewController.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/2017.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if LocalInstagramService.shared.isLoggedIn {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }

    @IBAction func onLogin(_ sender: Any) {
        do {
            try LocalInstagramService.shared.login(
                username: usernameField?.text ?? "demo",
                password: passwordField?.text ?? "demo"
            )
            performSegue(withIdentifier: "loginSegue", sender: nil)
        } catch {
            let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
