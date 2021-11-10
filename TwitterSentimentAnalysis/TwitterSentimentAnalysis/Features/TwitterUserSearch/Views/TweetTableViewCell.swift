//
//  TweetTableViewCell.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit

class TweetTableViewCell: TableViewCell {

    lazy var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 16.0)
        name.textColor = .black
        name.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        name.setContentHuggingPriority(.defaultHigh, for: .vertical)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    private func setupViews() {
        contentView.addSubviews([image, name, username, tweet])

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: imageHeight),
            image.widthAnchor.constraint(equalToConstant: imageHeight),
            image.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            name.topAnchor.constraint(equalTo: image.topAnchor),

            username.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            username.topAnchor.constraint(equalTo: image.topAnchor),

            tweet.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            tweet.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tweet.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            tweet.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func configure(withViewModel viewModel: TweetViewModel?) {
        name.text = viewModel?.name
        username.text = "@\(viewModel?.username ?? String())"
        tweet.text = viewModel?.text
        image.setImage(with: viewModel?.image)
    }
}
