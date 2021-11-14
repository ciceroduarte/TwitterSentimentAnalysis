//
//  Tweet.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

public struct Tweet: Decodable {
    public let text: String
    public let lang: String

    public init(text: String, lang: String) {
        self.text = text
        self.lang = lang
    }
}
