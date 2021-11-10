//
//  TwitterAPITests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import XCTest
@testable import TwitterSentimentAnalysis

class TwitterAPITests: XCTestCase {

    func test_twitterAPI_shouldSendTwitterKey() {
        let twitterKey = "testingTwitterKey"
        let sut = TwitterAPIMock(withTwitterKey: twitterKey, session: .shared)

        sut.fetchUser(byUsername: "") { _ in }

        XCTAssertTrue(sut.requestContainsTwitterKey)
    }

    func test_fetchUser_shouldReturnUser_onSuccess() {
        let sut = TwitterAPIMock(withTwitterKey: String(), session: .shared)
        sut.shouldReturnSuccess = true

        sut.fetchUser(byUsername: String()) { user in
            XCTAssertNotNil(user)
        }
    }

    func test_fetchUser_shouldReturnNil_onError() {
        let sut = TwitterAPIMock(withTwitterKey: String(), session: .shared)

        sut.fetchUser(byUsername: String()) { user in
            XCTAssertNil(user)
        }
    }

    func test_fetchTweets_shouldReturnTweets_onSuccess() {
        let sut = TwitterAPIMock(withTwitterKey: String(), session: .shared)
        sut.shouldReturnSuccess = true

        sut.fetchTweets(forUserIdentifier: String()) { tweets in
            XCTAssertFalse(tweets.isEmpty)
        }

    }

    func test_fetchTweets_shouldReturnEmpty_onError() {
        let sut = TwitterAPIMock(withTwitterKey: String(), session: .shared)

        sut.fetchTweets(forUserIdentifier: String()) { tweets in
            XCTAssertTrue(tweets.isEmpty)
        }
    }
}
