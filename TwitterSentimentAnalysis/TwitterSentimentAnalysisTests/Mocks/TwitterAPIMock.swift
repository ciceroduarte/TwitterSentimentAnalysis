//
//  TwitterAPIMock.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation
@testable import TwitterSentimentAnalysis

class TwitterAPIMock: TwitterAPI {

    var requestContainsTwitterKey = false
    var shouldReturnSuccess = false

    override func fetch<T>(_ representable: T.Type,
                           request: URLRequest,
                           completionHandler: @escaping (Result<T, FetchError>) -> Void) where T: Decodable {
        let authorization = request.allHTTPHeaderFields?["Authorization"] ?? String()
        requestContainsTwitterKey = authorization.contains(twitterKey)

        let response: T?
        switch (shouldReturnSuccess, representable) {
        case (true, is TwitterUserResponse.Type):
            response = TwitterUserResponse(data: User(id: String(),
                                                      username: String(),
                                                      name: String(),
                                                      profileImageUrl: URL(string: "http://url.com")!)) as? T

        case (true, is TweetsResponse.Type):
            response = TweetsResponse(data: [Tweet(text: "text", lang: "lang")]) as? T

        default:
            response = nil
        }

        if let response = response {
            completionHandler(.success(response))
        } else {
            completionHandler(.failure(.networkError))
        }
    }
}
