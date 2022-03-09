//
//  APIProvider.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//
import Foundation

public enum FetchError: Error {
    case networkError
    case invalidResponse
}

open class APIProvider {

    weak var session: URLSession?

    public init(withSession session: URLSession) {
        self.session = session
    }

    open func fetch<T: Decodable>(_ representable: T.Type,
                             request: URLRequest,
                             completionHandler: @escaping (Result<T, FetchError>) -> Void) {

        session?.dataTask(with: request, completionHandler: { data, _, error in
            guard error == nil, let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError))
                }
                return
            }

            let result: Result<T, FetchError>

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let responseValue = try decoder.decode(representable.self, from: data)

                result = .success(responseValue)

            } catch {
                result = .failure(.invalidResponse)
            }

            DispatchQueue.main.async {
                completionHandler(result)
            }

        }).resume()
    }
}
