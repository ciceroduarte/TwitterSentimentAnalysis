//
//  TwitterAPI.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

struct TwitterUserResponse: Decodable {
    let data: User
}

 struct TweetsResponse: Decodable {
    let data: [Tweet]
}

class TwitterAPI: APIProvider {

    let twitterKey: String

    private lazy var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.twitter.com"
        return components
    }()

    init(withTwitterKey twitterKey: String, session: URLSession) {
        self.twitterKey = twitterKey
        super.init(withSession: session)
    }

    func fetchUser(byUsername username: String, completionHandler: @escaping (User?) -> Void) {
        components.path = "/2/users/by/username/\(username)"
        components.queryItems = [
            URLQueryItem(name: "user.fields", value: "id,name,profile_image_url,username")
        ]

        let request = twitterRequest(withUrl: components.url)
        fetch(TwitterUserResponse.self, request: request, completionHandler: { result in
            switch result {
            case .success(let response):
                completionHandler(response.data)
            case .failure:
                completionHandler(nil)
            }
        })
    }

    func fetchTweets(forUserIdentifier userIdentifier: String, completion: @escaping ([Tweet]) -> Void) {
        components.path = "/2/users/\(userIdentifier)/tweets"
        components.queryItems = [
            URLQueryItem(name: "tweet.fields", value: "lang,text"),
            URLQueryItem(name: "max_results", value: "100")
        ]

        let request = twitterRequest(withUrl: components.url)
        fetch(TweetsResponse.self, request: request, completionHandler: { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure:
                completion([])
            }
        })
    }

    private func twitterRequest(withUrl url: URL?) -> URLRequest {
        var request = URLRequest(url: url!)
        request.addValue("Bearer \(twitterKey)", forHTTPHeaderField: "Authorization")
        return request
    }
}
