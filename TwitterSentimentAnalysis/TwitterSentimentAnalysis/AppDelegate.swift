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
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppSettings.setAppearance()

        let navigationController = UINavigationController()
        coordinator = AppCoordinator(withNavigationController: navigationController)
        coordinator?.start()

        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        return true
    }
}
