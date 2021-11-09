//
//  AppDelegate.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 08/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController(rootViewController: ViewController())

        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        return true
    }
}
