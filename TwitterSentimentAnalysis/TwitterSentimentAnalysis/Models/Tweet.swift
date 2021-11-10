//
//  Tweet.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import Foundation

struct Tweet: Decodable {
    let text: String
    let lang: String
}
