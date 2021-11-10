//
//  TwitterUserSearchViewController.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit

class TwitterUserSearchViewController: UIViewController {

    private let viewModel: TwitterUserSearchViewModel

    init(withViewModel viewModel: TwitterUserSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

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
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.tintColor = .black

        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    lazy var loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .white
        view.addSubviews([searchBar, tableView, loadingView])

        viewModel.delegate = self

        loadingView.hide()

        setupConstrints()
    }

    private func setupConstrints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44.0),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TwitterUserSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        loadingView.show()
        viewModel.searchUser(withText: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension TwitterUserSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TweetTableViewCell
        cell.configure(withViewModel: viewModel.tweetViewModel(forIndexPath: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
    }
}

extension TwitterUserSearchViewController: TwitterUserSearchViewModelDelegate {
    func tweetsDidChange() {
        tableView.reloadData()
        loadingView.hide()
    }

    func fetchDidFailed() {
        loadingView.hide()
    }
}
