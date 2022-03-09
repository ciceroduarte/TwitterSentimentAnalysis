//
//  APIProviderTests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//
import XCTest
@testable import NetworkingPackage

final class APIProviderTests: XCTestCase {

    var session: URLSessionMock?

    func test_fetch_shouldReturnSuccessForValidData() {
        let sut = makeSUT(withData: "[]")

        let response = fetch([String].self, withSUT: sut)

        XCTAssertEqual(response, .success([]))
    }

    func test_fetch_shouldReturnInvalidResponseForInvalidData() {
        let sut = makeSUT(withData: "{}")

        let response = fetch([String].self, withSUT: sut)

        XCTAssertEqual(response, .failure(.invalidResponse))
    }

    func test_fetch_shouldReturnNetworkError_whenErrorNotNil() {
        let sut = makeSUT(error: FetchError.networkError)

        let response = fetch([String].self, withSUT: sut)

        XCTAssertEqual(response, .failure(.networkError))
    }

    func test_fetch_shouldReturnNetworkError_whenDataIsNil() {
        let sut = makeSUT()

        let response = fetch([String].self, withSUT: sut)

        XCTAssertEqual(response, .failure(.networkError))
    }

    private func fetch<T: Decodable>(_ representable: T.Type,
                       withSUT sut: APIProvider) -> Result<T, FetchError>? {
        let expec = expectation(description: "Wait for fetch response")
        var response: Result<T, FetchError>?

        sut.fetch(representable,
                  request: URLRequest(url: URL(string: "http://anyurl.com")!)) { result in
            response = result
            expec.fulfill()
        }
        wait(for: [expec], timeout: 0.1)

        return response
    }

    private func makeSUT(withData data: String? = nil, error: Error? = nil) -> APIProvider {
        session = URLSessionMock(withData: data?.data(using: .utf8), error: error)
        let sut = APIProvider(withSession: session ?? URLSessionMock())

        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut)
        }

        return sut
    }
}

final class URLSessionMock: URLSession {

    let data: Data?
    let response: URLResponse?
    let error: Error?

    init(withData data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLSessionDataTaskMock(completion: { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        })
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask {

    let completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    override func resume() {
        completion()
    }
}
