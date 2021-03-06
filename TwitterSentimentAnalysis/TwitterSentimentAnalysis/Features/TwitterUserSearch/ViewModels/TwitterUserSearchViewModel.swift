//
//  TwitterUserSearchViewModel.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation
import TwitterAPIPackage

protocol TwitterUserSearchViewModelDelegate: AnyObject {
    func tweetsDidChange()
    func fetchDidFailed()
}

class TwitterUserSearchViewModel {

    private let twitterUserProvider: TwitterUserProvider
    private let coordinator: AppCoordinator
    weak var delegate: TwitterUserSearchViewModelDelegate?
    let title = "Twitter"

    var user: User? {
        didSet {
            if user == nil {
                tweets = []
                delegate?.fetchDidFailed()
            } else {
                fetchUserTweets()
            }
        }
    }

    var tweets: [Tweet] = [] {
        didSet {
            delegate?.tweetsDidChange()
        }
    }

    var numberOfRows: Int {
        tweets.count
    }

    init(withTwitterUserProvider twitterUserProvider: TwitterUserProvider, coordinator: AppCoordinator) {
        self.twitterUserProvider = twitterUserProvider
        self.coordinator = coordinator
    }

    func searchUser(withText text: String?) {
        guard let searchText = text, searchText.isEmpty == false else { return }

        twitterUserProvider.fetchUser(byUsername: searchText, completionHandler: { [weak self] user in
            self?.user = user
        })
    }

    func tweetViewModel(forIndexPath indexPath: IndexPath) -> TweetViewModel? {
        guard let user = user else { return nil }

        let tweet = tweets[indexPath.row]

        return TweetViewModel(name: user.name, username: user.username, text: tweet.text, image: user.profileImageUrl)
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let user = user else { return }

        let tweet = tweets[indexPath.row]

        coordinator.openTweetSentimentAnalysis(withUser: user, tweet: tweet)
    }

    private func fetchUserTweets() {
        guard let id = user?.id else { return }

        twitterUserProvider.fetchUserTimeline(withIdentifier: id, completion: { [weak self] tweets in
            self?.tweets = tweets
        })
    }
}
