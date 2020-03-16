//
//  AppDelegate.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 13/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TestController()
        window?.makeKeyAndVisible()
        return true
    }

}
