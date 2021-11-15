//
//  UIImageViewExtension.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

#if !os(macOS)

import UIKit
import Kingfisher

public extension UIImageView {

    func setImage(with url: URL?) {
        kf.setImage(with: url)
    }
}


#endif
