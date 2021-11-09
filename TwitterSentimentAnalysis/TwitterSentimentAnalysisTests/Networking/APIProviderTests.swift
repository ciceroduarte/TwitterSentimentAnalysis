//
//  APIProviderTests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import XCTest
@testable import TwitterSentimentAnalysis

class APIProviderTests: XCTestCase {

    lazy var request = URLRequest(url: URL(string: "http://www.url.com")!)
    var session: URLSessionMock?

    func test_fetch_shouldReturnSuccess_whenValidResponse() {
        let expec = expectation(description: "Should return a valid response")
        let sut = makeSUT(withData: "[]")

        sut.fetch([String].self, request: request) { result in
            if case .success = result {
                expec.fulfill()
            }
        }
        wait(for: [expec], timeout: 0.1)
    }

    func test_fetch_shouldReturnFetchError_whenInvalidResponse() {
        let expec = expectation(description: "Should return a valid response")
        let sut = makeSUT(withData: "{}")

        sut.fetch([String].self, request: request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .invalidResponse)
                expec.fulfill()
            }
        }
        wait(for: [expec], timeout: 0.1)
    }

    func test_fetch_shouldReturnNetworkError_whenErrorNotNil() {
        let expec = expectation(description: "Should return a valid response")
        let sut = makeSUT(error: FetchError.networkError)

        sut.fetch([String].self, request: request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .networkError)
                expec.fulfill()
            }
        }
        wait(for: [expec], timeout: 0.1)
    }

    func test_fetch_shouldReturnNetworkError_whenDataIsNil() {
        let expec = expectation(description: "Should return a valid response")
        let sut = makeSUT()

        sut.fetch([String].self, request: request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .networkError)
                expec.fulfill()
            }
        }
        wait(for: [expec], timeout: 0.1)
    }

    private func makeSUT(withData data: String? = nil, error: Error? = nil) -> APIProvider {
        session = URLSessionMock(withData: data?.data(using: .utf8), error: error)
        return APIProvider(withSession: session ?? URLSessionMock())
    }
}
