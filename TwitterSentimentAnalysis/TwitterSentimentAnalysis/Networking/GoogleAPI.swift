//
//  GoogleAPI.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

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

class GoogleAPI: APIProvider {

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

    init(withGoogleKey googleKey: String, session: URLSession) {
        self.googleKey = googleKey
        super.init(withSession: session)
    }

    func analyzeSentiment(forContent content: String, language: String, completion: @escaping (Float?) -> Void) {

        guard let url = components.url else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body = GoogleAPIBody(document: GoogleAPIBody.Document(language: language, content: content))

        guard let jsonData = try? JSONEncoder().encode(body) else {
            completion(nil)
            return
        }

        request.httpBody = jsonData

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
