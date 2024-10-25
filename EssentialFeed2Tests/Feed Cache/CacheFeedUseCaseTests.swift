//
//  CacheFeedUseCaseTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 24/10/24.
//

import XCTest

class LocalFeedLoaer {
  init(store: FeedStore) {

  }
}

class FeedStore {
  var deleteCacheFeedCallCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoaer(store: store)

        XCTAssertEqual(store.deleteCacheFeedCallCount, 0)
    }

}
