//
//  AppDelegate.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/8/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
     -> Void in
        configuration.applicationId = "Instagram"
        configuration.clientKey = "askdj;alcds;lcskak;lsadcjsad;klcj"  // set to nil assuming you have not set clientKey
        configuration.server = "https://fast-citadel-91087.herokuapp.com/parse"
      }))
    if PFUser.current() != nil {
      // if there is a logged in user then load the home view controller
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      PFUser.logOutInBackground()
      let vc = storyboard.instantiateInitialViewController()
      window?.rootViewController = vc
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateInitialViewController()
      window?.rootViewController = vc
    }
    // Code to initialize Parse
    // (See above section 'Parse `initializeWithConfiguration` vs `setApplicationId`', if you have not already set it up)

    // check if user is logged in.
   /* if PFUser.current() != nil {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      // view controller currently being set in Storyboard as default will be overridden
      window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController")
    }*/

    return true
  }






}

