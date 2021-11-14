//
//  User.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

public struct User: Decodable {
    public let id: String
    public let username: String
    public let name: String
    public let profileImageUrl: URL

    public init(id: String, username: String, name: String, profileImageUrl: URL) {
        self.id = id
        self.username = username
        self.name = name
        self.profileImageUrl = profileImageUrl
    }

}
