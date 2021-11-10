//
//  UIImageViewExtension.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(with url: URL?) {
        kf.setImage(with: url)
    }
}
