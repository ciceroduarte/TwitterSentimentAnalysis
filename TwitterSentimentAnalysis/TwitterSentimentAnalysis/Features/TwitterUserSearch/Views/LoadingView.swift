//
//  LoadingView.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit
import TwitterSentimentAnalysisCorePackage

class LoadingView: View {

    lazy var activityIndicatorView = UIActivityIndicatorView(style: .gray)

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white
        addSubviews([activityIndicatorView])
        activityIndicatorView.startAnimating()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func show() {
        isHidden = false
        activityIndicatorView.startAnimating()
    }

    func hide() {
        isHidden = true
        activityIndicatorView.stopAnimating()
    }
}
