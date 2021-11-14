//
//  GoogleAPI.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation
import NetworkingPackage

struct DocumentSentimentResponse: Decodable {
    let documentSentiment: DocumentSentiment
}

private struct GoogleAPIBody: Encodable {
    let document: Document
    let encodingType = "UTF8"

    struct Document: Encodable {
        let type = "PLAIN_TEXT"
        let language: String
        let content: String
    }
}

public class GoogleAPI: APIProvider, DocumentSentimentAnalyzer {

    let googleKey: String
    private lazy var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "language.googleapis.com"
        components.path = "/v1/documents:analyzeSentiment"
        components.queryItems = [
            URLQueryItem(name: "key", value: googleKey)
        ]
        return components
    }()

    public init(withGoogleKey googleKey: String, session: URLSession) {
        self.googleKey = googleKey
        super.init(withSession: session)
    }

    public func analyzeSentiment(forContent content: String, language: String, completion: @escaping (Float?) -> Void) {
        var request = URLRequest(url: components.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body = GoogleAPIBody(document: GoogleAPIBody.Document(language: language, content: content))

        request.httpBody = try? JSONEncoder().encode(body)

        fetch(DocumentSentimentResponse.self, request: request, completionHandler: { result in
            switch result {
            case .success(let response):
                completion(response.documentSentiment.score)
            case .failure:
                completion(nil)
            }
        })
    }
}
