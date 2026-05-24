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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        window?.rootViewController = vc
        return true
    }
}
