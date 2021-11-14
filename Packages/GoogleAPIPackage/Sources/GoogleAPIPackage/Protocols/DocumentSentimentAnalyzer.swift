//
//  DocumentSentimentAnalyzer.swift
//  
//
//  Created by Cicero Duarte on 14/11/21.
//

import Foundation

public protocol DocumentSentimentAnalyzer {
    func analyzeSentiment(forContent content: String, language: String, completion: @escaping (Float?) -> Void)
}
