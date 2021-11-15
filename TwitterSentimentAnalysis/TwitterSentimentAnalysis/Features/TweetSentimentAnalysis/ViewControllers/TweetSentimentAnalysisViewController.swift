//
//  TweetSentimentAnalysisViewController.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit
import TwitterSentimentAnalysisCorePackage

class TweetSentimentAnalysisViewController: ViewController {

    let viewModel: TweetSentimentAnalysisViewModel
    lazy var tweetSentimentAnalysisView = TweetSentimentAnalysisView()

    init(withViewModel viewModel: TweetSentimentAnalysisViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews([tweetSentimentAnalysisView])

        tweetSentimentAnalysisView.name.text = viewModel.name
        tweetSentimentAnalysisView.username.text = viewModel.username
        tweetSentimentAnalysisView.tweet.text = viewModel.text
        tweetSentimentAnalysisView.image.setImage(with: viewModel.profileImageUrl)

        setupConstraints()

        viewModel.analyzeSentiment(completionHandler: { [weak self] score in
            self?.tweetSentimentAnalysisView.sentimentView.setScore(score)
        })
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tweetSentimentAnalysisView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tweetSentimentAnalysisView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tweetSentimentAnalysisView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            tweetSentimentAnalysisView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
