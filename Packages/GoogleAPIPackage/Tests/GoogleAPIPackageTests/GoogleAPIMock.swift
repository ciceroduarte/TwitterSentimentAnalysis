//
//  GoogleAPIMock.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 10/11/21.
//

import Foundation
import NetworkingPackage

@testable import GoogleAPIPackage

class GoogleAPIMock: GoogleAPI {

    var requestContainsGoogleKey = false
    var shouldReturnSuccess = false

    override func fetch<T>(_ representable: T.Type,
                           request: URLRequest,
                           completionHandler: @escaping (Result<T, FetchError>) -> Void) where T: Decodable {
        let urlString = request.url?.absoluteString ?? String()
        requestContainsGoogleKey = urlString.contains(googleKey)

        if shouldReturnSuccess {

            let documentSentiment = DocumentSentiment(score: 1.0)
            let documentSentimentResponse = DocumentSentimentResponse(documentSentiment: documentSentiment)

            guard let response = documentSentimentResponse as? T else {
                completionHandler(.failure(.networkError))
                return
            }

            completionHandler(.success(response))
        } else {
            completionHandler(.failure(.networkError))
        }
    }
}
