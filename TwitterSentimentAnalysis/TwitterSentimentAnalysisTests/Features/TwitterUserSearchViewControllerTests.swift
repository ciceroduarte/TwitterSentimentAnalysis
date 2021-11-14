//
//  TwitterUserSearchViewControllerTests.swift
//  TwitterSentimentAnalysisTests
//
//  Created by Cicero Duarte on 09/11/21.
//

import XCTest
import TwitterAPIPackage

@testable import TwitterSentimentAnalysis

class TwitterUserSearchViewControllerTests: XCTestCase {

    lazy var twitterUserProvider = TwitterUserProviderMock()
    lazy var navigationControllerSpy = NavigationControllerSpy()
    lazy var coordinator = AppCoordinator(withNavigationController: navigationControllerSpy)
    lazy var viewModel = TwitterUserSearchViewModel(withTwitterUserProvider: twitterUserProvider, coordinator: coordinator)
    lazy var sut = TwitterUserSearchViewController(withViewModel: viewModel)

    func test_loadingView_shouldStartHidden() {
        sut.viewDidLoad()

        XCTAssertTrue(sut.twitterUSerSerchView.loadingView.isHidden)
    }

    func test_loadingView_shouldShow_onSearch() {
        sut.searchBarSearchButtonClicked(sut.twitterUSerSerchView.searchBar)

        XCTAssertFalse(sut.twitterUSerSerchView.loadingView.isHidden)
    }

    func test_searchBar_shouldShowCancelbutton_onTextDidDidBeginEditing() {
        sut.searchBarTextDidBeginEditing(sut.twitterUSerSerchView.searchBar)

        XCTAssertTrue(sut.twitterUSerSerchView.searchBar.showsCancelButton)
    }

    func test_searchBar_shouldHideCancelButton_onTextDidEndEditing() {
        sut.searchBarTextDidBeginEditing(sut.twitterUSerSerchView.searchBar)
        sut.searchBarTextDidEndEditing(sut.twitterUSerSerchView.searchBar)

        XCTAssertFalse(sut.twitterUSerSerchView.searchBar.showsCancelButton)
    }

    func test_searchBar_shouldHideKeyboard_onCancelClick() {
        let searchBarSpy = SearchBarSpy()
        sut.twitterUSerSerchView.searchBar = searchBarSpy

        sut.searchBarCancelButtonClicked(sut.twitterUSerSerchView.searchBar)

        XCTAssertTrue(searchBarSpy.resignFirstResponderWasCalled)
    }

    func test_numberOfRows_shouldBeEqualToNumberOfTweets() {
        viewModel.tweets.append(Tweet(text: String(), lang: String()))

        let numberOfRows = sut.tableView(sut.twitterUSerSerchView.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(numberOfRows, viewModel.tweets.count)
    }

    func test_cellForRowAt_shouldReturnTweetTableViewCell() {
        viewModel.tweets.append(Tweet(text: String(), lang: String()))

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.twitterUSerSerchView.tableView, cellForRowAt: indexPath)

        XCTAssertTrue(cell is TweetTableViewCell)
    }

    func test_cellForRowAt_shouldReturnConfiguredCell() {
        twitterUserProvider.shouldReturnSuccess = true
        sut.twitterUSerSerchView.searchBar.text = "testing"

        sut.searchBarSearchButtonClicked(sut.twitterUSerSerchView.searchBar)

        let indexPath = IndexPath(row: 0, section: 0)

        let cell = sut.tableView(sut.twitterUSerSerchView.tableView, cellForRowAt: indexPath) as? TweetTableViewCell

        XCTAssertNotNil(cell)
    }

    func test_tweetsUpdate_shouldCallTweetsDidChange() {
        let tweet = Tweet(text: String(), lang: String())
        sut.viewDidLoad()

        sut.twitterUSerSerchView.loadingView.show()
        viewModel.tweets = [tweet]

        XCTAssertTrue(sut.twitterUSerSerchView.loadingView.isHidden)
        XCTAssertEqual(sut.tableView(sut.twitterUSerSerchView.tableView, numberOfRowsInSection: 0), 1)
    }

    func test_invalidUser_shouldHideLoading() {
        sut.viewDidLoad()

        sut.twitterUSerSerchView.loadingView.show()
        viewModel.user = nil

        XCTAssertTrue(sut.twitterUSerSerchView.loadingView.isHidden)
    }

    func test_fetchSuccess_shouldLoadTweets() {
        sut.viewDidLoad()
        twitterUserProvider.shouldReturnSuccess = true

        sut.twitterUSerSerchView.searchBar.text = "testing"
        sut.searchBarSearchButtonClicked(sut.twitterUSerSerchView.searchBar)

        XCTAssertTrue(sut.tableView(sut.twitterUSerSerchView.tableView, numberOfRowsInSection: 0) != 0)
    }

    func test_didSelectRowAt_shouldOpenTweetSentimentAnalysis() {
        sut.viewDidLoad()
        twitterUserProvider.shouldReturnSuccess = true

        sut.twitterUSerSerchView.searchBar.text = "testing"
        sut.searchBarSearchButtonClicked(sut.twitterUSerSerchView.searchBar)
        sut.tableView(sut.twitterUSerSerchView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

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

class TwitterUserProviderMock: TwitterUserProvider {

    var shouldReturnSuccess = false

    func fetchUser(byUsername username: String, completionHandler: @escaping (User?) -> Void) {
        let user: User? = shouldReturnSuccess ? User(id: String(), username: String(), name: String(), profileImageUrl: URL(string: "http://url.com")!) : nil

        completionHandler(user)
    }

    func fetchUserTimeline(withIdentifier userIdentifier: String, completion: @escaping ([Tweet]) -> Void) {
        let tweets = shouldReturnSuccess ? [Tweet(text: String(), lang: String())] : []
        completion(tweets)
    }
}
