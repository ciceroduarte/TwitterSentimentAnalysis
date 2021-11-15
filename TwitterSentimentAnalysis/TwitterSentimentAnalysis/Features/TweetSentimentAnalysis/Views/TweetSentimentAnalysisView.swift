//
//  TweetSentimentAnalysisView.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 10/11/21.
//

import UIKit
import TwitterSentimentAnalysisCorePackage

class TweetSentimentAnalysisView: View {

    lazy var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 16.0)
        name.textColor = .black
        return name
    }()

    lazy var username: UILabel = {
        let username = UILabel()
        username.font = UIFont.systemFont(ofSize: 15.0)
        username.textColor = .gray
        return username
    }()

    let imageHeight: CGFloat = 50.0
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = imageHeight / 2.0
        image.clipsToBounds = true
        return image
    }()

    lazy var tweet: UILabel = {
        let tweet = UILabel()
        tweet.numberOfLines = 0
        tweet.font = UIFont.systemFont(ofSize: 15.0)
        tweet.textColor = .darkGray
        return tweet
    }()

    lazy var sentimentView: SentimentView = {
        let sentimentView = SentimentView()
        sentimentView.layer.cornerRadius = 10
        return sentimentView
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white
        addSubviews([image, name, username, tweet, sentimentView])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: imageHeight),
            image.widthAnchor.constraint(equalToConstant: imageHeight),

            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            name.topAnchor.constraint(equalTo: image.topAnchor),

            username.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            username.bottomAnchor.constraint(equalTo: image.bottomAnchor),

            tweet.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 8),
            tweet.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tweet.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),

            sentimentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sentimentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sentimentView.topAnchor.constraint(greaterThanOrEqualTo: tweet.bottomAnchor, constant: 16),
            sentimentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            sentimentView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
