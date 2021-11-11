//
//  TwitterUserSearchViewController.swift
//  TwitterSentimentAnalysis
//
//  Created by Cicero Duarte on 09/11/21.
//

import UIKit

class TwitterUserSearchViewController: ViewController {

    private let viewModel: TwitterUserSearchViewModel
    lazy var twitterUSerSerchView = TwitterUserSearchView()

    init(withViewModel viewModel: TwitterUserSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .white
        view.addSubviews([twitterUSerSerchView])

        viewModel.delegate = self

        twitterUSerSerchView.tableView.delegate = self
        twitterUSerSerchView.tableView.dataSource = self
        twitterUSerSerchView.searchBar.delegate = self
        twitterUSerSerchView.userNotFoundView.hide()
        twitterUSerSerchView.loadingView.hide()

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            twitterUSerSerchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            twitterUSerSerchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            twitterUSerSerchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            twitterUSerSerchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TwitterUserSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        twitterUSerSerchView.loadingView.show()
        twitterUSerSerchView.userNotFoundView.hide()
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
        twitterUSerSerchView.tableView.reloadData()
        twitterUSerSerchView.loadingView.hide()
    }

    func fetchDidFailed() {
        twitterUSerSerchView.loadingView.hide()
        twitterUSerSerchView.userNotFoundView.show()
    }
}
