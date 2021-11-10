//
//  UserNotFoundView.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 10/11/21.
//

import Foundation
import UIKit

class UserNotFoundView: View {

    lazy var text: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 20.0)
        text.textColor = .darkGray
        text.text = "User not found!"
        text.textAlignment = .center
        return text
    }()

    lazy var emoji: UILabel = {
        let emoji = UILabel()
        emoji.font = UIFont.systemFont(ofSize: 35.0)
        emoji.text = "🙈"
        emoji.textAlignment = .center
        return emoji
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white
        addSubviews([text, emoji])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            text.leadingAnchor.constraint(equalTo: leadingAnchor),
            text.trailingAnchor.constraint(equalTo: trailingAnchor),

            emoji.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 8),
            emoji.leadingAnchor.constraint(equalTo: leadingAnchor),
            emoji.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func show() {
        isHidden = false
    }

    func hide() {
        isHidden = true
    }

}
