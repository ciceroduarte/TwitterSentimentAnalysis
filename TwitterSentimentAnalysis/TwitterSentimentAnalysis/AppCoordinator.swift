//
//  AppCoordinator.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit
import GoogleAPIPackage
import TwitterAPIPackage

struct AppCoordinator {

    let navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let twitterAPI = TwitterAPI(withTwitterKey: AppSettings.twitterKey, session: .shared)
        let viewModel = TwitterUserSearchViewModel(withTwitterUserProvider: twitterAPI, coordinator: self)
        let searchUserViewController = TwitterUserSearchViewController(withViewModel: viewModel)
        navigationController.pushViewController(searchUserViewController, animated: false)
    }

    func openTweetSentimentAnalysis(withUser user: User, tweet: Tweet) {
        let googleAPI = GoogleAPI(withGoogleKey: AppSettings.googleKey, session: .shared)
        let viewModel = TweetSentimentAnalysisViewModel(sentimentAnalyzer: googleAPI, tweet: tweet, user: user)
        let tweetViewController = TweetSentimentAnalysisViewController(withViewModel: viewModel)
        navigationController.pushViewController(tweetViewController, animated: true)
    }
}
