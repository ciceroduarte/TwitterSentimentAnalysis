//
//  AppSettings.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit

// swiftlint:disable line_length
struct AppSettings {
    static let twitterKey = "twitterKey"
    static let googleKey = "googleKey"

    static func setAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.barTintColor = .white
        navigationBarAppearance.tintColor = .black

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .white
            navigationBarAppearance.standardAppearance = appearance
            navigationBarAppearance.scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
        }

        let tableViewAppearance = UITableView.appearance()
        tableViewAppearance.backgroundColor = .white
        tableViewAppearance.separatorStyle = .none

        UITableViewCell.appearance().selectionStyle = .none
    }
}
