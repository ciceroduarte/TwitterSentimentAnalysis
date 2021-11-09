//
//  APIProvider.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

enum FetchError: Error {
    case networkError
    case invalidResponse
}

class APIProvider {

    weak var session: URLSession?

    init(withSession session: URLSession) {
        self.session = session
    }

    func fetch<T: Decodable>(_ representable: T.Type,
                             request: URLRequest,
                             completionHandler: @escaping (Result<T, FetchError>) -> Void) {

        session?.dataTask(with: request, completionHandler: { data, _, error in
            guard error == nil, let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let responseValue = try decoder.decode(representable.self, from: data)

                DispatchQueue.main.async {
                    completionHandler(.success(responseValue))
                }

            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidResponse))
                }
            }
        }).resume()
    }
}
