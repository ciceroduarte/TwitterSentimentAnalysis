//
//  TwitterUserSearchViewControllerTests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import XCTest
@testable import TwitterSentimentAnalysis

class TwitterUserSearchViewControllerTests: XCTestCase {

    lazy var twitterAPI = TwitterAPIMock(withTwitterKey: String(), session: .shared)
    lazy var navigationControllerSpy = NavigationControllerSpy()
    lazy var coordinator = AppCoordinator(withNavigationController: navigationControllerSpy)
    lazy var viewModel = TwitterUserSearchViewModel(withTwitterAPI: twitterAPI, coordinator: coordinator)
    lazy var sut = TwitterUserSearchViewController(withViewModel: viewModel)

    func test_loadingView_shouldStartHidden() {
        sut.viewDidLoad()

        XCTAssertTrue(sut.loadingView.isHidden)
    }

    func test_loadingView_shouldShow_onSearch() {
        sut.searchBarSearchButtonClicked(sut.searchBar)

        XCTAssertFalse(sut.loadingView.isHidden)
    }

    func test_searchBar_shouldShowCancelbutton_onTextDidDidBeginEditing() {
        sut.searchBarTextDidBeginEditing(sut.searchBar)

        XCTAssertTrue(sut.searchBar.showsCancelButton)
    }

    func test_searchBar_shouldHideCancelButton_onTextDidEndEditing() {
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        sut.searchBarTextDidEndEditing(sut.searchBar)

        XCTAssertFalse(sut.searchBar.showsCancelButton)
    }

    func test_searchBar_shouldHideKeyboard_onCancelClick() {
        let searchBarSpy = SearchBarSpy()
        sut.searchBar = searchBarSpy

        sut.searchBarCancelButtonClicked(sut.searchBar)

        XCTAssertTrue(searchBarSpy.resignFirstResponderWasCalled)
    }

    func test_numberOfRows_shouldBeEqualToNumberOfTweets() {
        viewModel.tweets.append(Tweet(text: String(), lang: String()))

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), viewModel.tweets.count)
    }

    func test_cellForRowAt_shouldReturnTweetTableViewCell() {
        viewModel.tweets.append(Tweet(text: String(), lang: String()))

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)

        XCTAssertTrue(cell is TweetTableViewCell)
    }

    func test_cellForRowAt_shouldReturnConfiguredCell() {
        twitterAPI.shouldReturnSuccess = true
        sut.searchBar.text = "testing"

        sut.searchBarSearchButtonClicked(sut.searchBar)

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath) as? TweetTableViewCell

        XCTAssertNotNil(cell)
    }

    func test_tweetsUpdate_shouldCallTweetsDidChange() {
        let tweet = Tweet(text: String(), lang: String())
        sut.viewDidLoad()

        sut.loadingView.show()
        viewModel.tweets = [tweet]

        XCTAssertTrue(sut.loadingView.isHidden)
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 1)
    }

    func test_invalidUser_shouldHideLoading() {
        sut.viewDidLoad()

        sut.loadingView.show()
        viewModel.user = nil

        XCTAssertTrue(sut.loadingView.isHidden)
    }

    func test_fetchSuccess_shouldLoadTweets() {
        sut.viewDidLoad()
        twitterAPI.shouldReturnSuccess = true

        sut.searchBar.text = "testing"
        sut.searchBarSearchButtonClicked(sut.searchBar)

        XCTAssertTrue(sut.tableView(sut.tableView, numberOfRowsInSection: 0) != 0)
    }

    func test_didSelectRowAt_shouldOpenTweetSentimentAnalysis() {
        sut.viewDidLoad()
        twitterAPI.shouldReturnSuccess = true

        sut.searchBar.text = "testing"
        sut.searchBarSearchButtonClicked(sut.searchBar)
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(navigationControllerSpy.pushViewControllerWasCalled)
    }
}

class SearchBarSpy: UISearchBar {

    var resignFirstResponderWasCalled = false

    override func resignFirstResponder() -> Bool {
        resignFirstResponderWasCalled = true
        return true
    }
}

class NavigationControllerSpy: UINavigationController {

    var pushViewControllerWasCalled = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerWasCalled = true
    }
}
