//
//  AppCoordinator.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit

struct AppCoordinator {

    let navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let twitterAPI = TwitterAPI(withTwitterKey: AppSettings.twitterKey, session: .shared)
        let viewModel = TwitterUserSearchViewModel(withTwitterAPI: twitterAPI, coordinator: self)
        let searchUserViewController = TwitterUserSearchViewController(withViewModel: viewModel)
        navigationController.pushViewController(searchUserViewController, animated: false)
    }
}
