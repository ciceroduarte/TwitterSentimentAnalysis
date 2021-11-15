//
//  TwitterUserSearchView.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 10/11/21.
//

import UIKit
import TwitterSentimentAnalysisCorePackage

class TwitterUserSearchView: View {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0

        tableView.register(TweetTableViewCell.self)

        return tableView
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Twitter user"
        searchBar.backgroundColor = .white
        searchBar.tintColor = .black

        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    lazy var loadingView = LoadingView()
    lazy var userNotFoundView = UserNotFoundView()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        addSubviews([searchBar, tableView, loadingView, userNotFoundView])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44.0),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),

            userNotFoundView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            userNotFoundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userNotFoundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userNotFoundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
