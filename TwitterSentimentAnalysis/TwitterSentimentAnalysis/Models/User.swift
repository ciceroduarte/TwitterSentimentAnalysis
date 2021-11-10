//
//  User.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

struct User: Decodable {
    let id: String
    let username: String
    let name: String
    let profileImageUrl: URL
}
