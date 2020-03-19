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
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.coordinator = AppCoordinator(tabBarController: UITabBarController())

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.coordinator?.rootController
        self.window?.makeKeyAndVisible()

        self.coordinator?.start()

        return true
    }

}
