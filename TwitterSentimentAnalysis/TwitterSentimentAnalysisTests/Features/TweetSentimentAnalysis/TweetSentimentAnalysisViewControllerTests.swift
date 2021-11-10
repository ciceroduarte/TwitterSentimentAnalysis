//
//  TweetSentimentAnalysisViewControllerTests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 10/11/21.
//

import XCTest
@testable import TwitterSentimentAnalysis

class TweetSentimentAnalysisVCTests: XCTestCase {

    lazy var googleAPI = GoogleAPIMock(withGoogleKey: String(), session: .shared)
    lazy var navigationController = UINavigationController()
    lazy var user = User(id: String(), username: String(), name: String(), profileImageUrl: URL(string: "http:url")!)
    lazy var tweet = Tweet(text: String(), lang: String())
    lazy var viewModel = TweetSentimentAnalysisViewModel(googleAPI: googleAPI, tweet: tweet, user: user)
    lazy var sut = TweetSentimentAnalysisViewController(withViewModel: viewModel)

    func test_initWithCoder_shouldBeNil() {
        XCTAssertNil(TweetSentimentAnalysisViewController(coder: NSCoder()))
    }

    func test_sentimentalAnalysis_shouldSetScore() {
        googleAPI.shouldReturnSuccess = true
        sut.viewDidLoad()

        XCTAssertTrue(sut.sentimentView.backgroundColor == .green)
    }
}
