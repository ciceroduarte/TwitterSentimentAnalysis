//
//  SentimentView.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit
import TwitterSentimentAnalysisCorePackage

class SentimentView: View {

    lazy var activityIndicatorView = UIActivityIndicatorView(style: .gray)

    lazy var sentiment: UILabel = {
        let sentiment = UILabel()
        sentiment.font = UIFont.systemFont(ofSize: 35.0)
        return sentiment
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .lightGray

        addSubviews([sentiment, activityIndicatorView])

        isAccessibilityElement = true

        activityIndicatorView.startAnimating()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),

            sentiment.centerYAnchor.constraint(equalTo: centerYAnchor),
            sentiment.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setScore(_ score: Float) {
        var accessibilityLabel = "Sentimental analysis result is: "
        switch score {
        case -1.0...(-0.3):
            sentiment.text = "😞"
            backgroundColor = .red
            accessibilityLabel += "sad"
        case 0.3...1.0:
            sentiment.text = "😃"
            backgroundColor = .green
            accessibilityLabel += "happy"
        default:
            sentiment.text = "😐"
            backgroundColor = .yellow
            accessibilityLabel += "neutral"
        }
        activityIndicatorView.stopAnimating()
        self.accessibilityLabel = accessibilityLabel
    }

}
