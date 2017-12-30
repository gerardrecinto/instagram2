//
//  LoginViewController.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/8/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var usernameField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  @IBAction func onSignIn(_ sender: Any) {
    PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
      if user != nil {
        print("logged in")
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
      }
    }
  }
  
  @IBAction func onSignUp(_ sender: Any) {
  let newUser = PFUser()
  newUser.username = usernameField.text
    newUser.password = passwordField.text
    newUser.signUpInBackground { (success: Bool, error: Error?) in
      if success {
        print("user created")
        self.performSegue(withIdentifier: "loginSegue", sender: nil)

      } else {
        print(error?.localizedDescription)
      }
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
