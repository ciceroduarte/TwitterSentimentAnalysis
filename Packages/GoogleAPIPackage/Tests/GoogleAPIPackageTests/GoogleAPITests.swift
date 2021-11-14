//
//  GoogleAPITests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 10/11/21.
//

import XCTest

@testable import GoogleAPIPackage

class GoogleAPITests: XCTestCase {

    func test_googelAPI_shouldSendGoogleKey() {
        let googleKey = "testingGoogleKey"
        let sut = GoogleAPIMock(withGoogleKey: googleKey, session: .shared)

        sut.analyzeSentiment(forContent: String(), language: String()) { _ in }

        XCTAssertTrue(sut.requestContainsGoogleKey)
    }

    func test_analyzeSentiment_shouldReturnScore_onSuccess() {
        let sut = GoogleAPIMock(withGoogleKey: String(), session: .shared)
        sut.shouldReturnSuccess = true

        sut.analyzeSentiment(forContent: String(), language: String()) { score in
            XCTAssertNotNil(score)
        }
    }

    func test_analyzeSentiment_shouldReturnNil_onError() {
        let sut = GoogleAPIMock(withGoogleKey: String(), session: .shared)

        sut.analyzeSentiment(forContent: String(), language: String()) { score in
            XCTAssertNil(score)
        }
    }
}
