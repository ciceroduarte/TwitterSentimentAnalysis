//
//  URLSessionDataTaskMock.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {

    let completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    override func resume() {
        completion()
    }
}
