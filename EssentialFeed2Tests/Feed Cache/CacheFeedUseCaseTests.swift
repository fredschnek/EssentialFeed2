//
//  CacheFeedUseCaseTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 24/10/24.
//

import XCTest
import EssentialFeed2

class LocalFeedLoaer {
  private let store: FeedStore

  init(store: FeedStore) {
    self.store = store
  }

  func save(_ items: [FeedItem]) {
    store.deleteCacheFeed()
  }
}

class FeedStore {
  var deleteCacheFeedCallCount = 0

  func deleteCacheFeed() {
    deleteCacheFeedCallCount += 1
  }
}

final class CacheFeedUseCaseTests: XCTestCase {

  func test_init_doesNotDeleteCacheUponCreation() {
    let store = FeedStore()
    _ = LocalFeedLoaer(store: store)

    XCTAssertEqual(store.deleteCacheFeedCallCount, 0)
  }

  func test_save_requestCacheDeletion() {
    let store = FeedStore()
    let sut = LocalFeedLoaer(store: store)
    let items = [uniqueItem(), uniqueItem()]

    sut.save(items)

    XCTAssertEqual(store.deleteCacheFeedCallCount, 1)
  }

}

extension CacheFeedUseCaseTests {
  private func uniqueItem() -> FeedItem {
    FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
  }

  private func anyURL() -> URL {
    URL(string: "http://any-url.com")!
  }
}
