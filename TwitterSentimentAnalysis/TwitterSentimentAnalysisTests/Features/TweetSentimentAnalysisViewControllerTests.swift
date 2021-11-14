//
//  TweetSentimentAnalysisViewControllerTests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 10/11/21.
//

import XCTest
import TwitterAPIPackage
import GoogleAPIPackage

@testable import TwitterSentimentAnalysis

class TweetSentimentAnalysisVCTests: XCTestCase {

    lazy var sentimentAnalyzer = SentimentAnalyzerMock()
    lazy var navigationController = UINavigationController()
    lazy var user = User(id: String(), username: String(), name: String(), profileImageUrl: URL(string: "http:url")!)
    lazy var tweet = Tweet(text: String(), lang: String())
    lazy var viewModel = TweetSentimentAnalysisViewModel(sentimentAnalyzer: sentimentAnalyzer, tweet: tweet, user: user)
    lazy var sut = TweetSentimentAnalysisViewController(withViewModel: viewModel)

    func test_sentimentalAnalysis_shouldSetScore() {
        sentimentAnalyzer.shouldReturnSuccess = true
        sut.viewDidLoad()

        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .green)
    }

    func test_sentimentView_SadRange() {
        sut.viewDidLoad()

        sut.tweetSentimentAnalysisView.sentimentView.setScore(-1.0)
        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .red)

        sut.tweetSentimentAnalysisView.sentimentView.setScore(-0.3)
        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .red)

        sut.tweetSentimentAnalysisView.sentimentView.setScore(-0.2)
        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .yellow)
    }

    func test_sentimentView_HappyRange() {
        sut.viewDidLoad()

        sut.tweetSentimentAnalysisView.sentimentView.setScore(0.3)
        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .green)

        sut.tweetSentimentAnalysisView.sentimentView.setScore(1.0)
        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .green)

        sut.tweetSentimentAnalysisView.sentimentView.setScore(0.2)
        XCTAssertTrue(sut.tweetSentimentAnalysisView.sentimentView.backgroundColor == .yellow)
    }

}

class SentimentAnalyzerMock: DocumentSentimentAnalyzer {

    var shouldReturnSuccess = false

    func analyzeSentiment(forContent content: String, language: String, completion: @escaping (Float?) -> Void) {
        let score: Float? = shouldReturnSuccess ? 1.0 : nil
        completion(score)
    }
}
