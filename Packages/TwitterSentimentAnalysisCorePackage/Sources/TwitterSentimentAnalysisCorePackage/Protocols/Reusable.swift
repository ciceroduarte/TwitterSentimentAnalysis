//
//  Reusable.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit

public protocol Reusable: AnyObject {}

public extension Reusable where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
