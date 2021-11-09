//
//  URLSessionMock.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

class URLSessionMock: URLSession {

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
