//
//  TweetSentimentAnalysisViewModel.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

struct TweetSentimentAnalysisViewModel {

    let googleAPI: GoogleAPI
    var tweet: Tweet
    var user: User

    var name: String {
        user.name
    }

    var username: String {
        "@\(user.username)"
    }

    var text: String {
        tweet.text
    }

    var profileImageUrl: URL {
        user.profileImageUrl
    }

    func analyzeSentiment(completionHandler: @escaping (Float) -> Void) {
        googleAPI.analyzeSentiment(forContent: tweet.text, language: tweet.lang) { score in
            guard let score = score else { return }
            completionHandler(score)
        }
    }
}
