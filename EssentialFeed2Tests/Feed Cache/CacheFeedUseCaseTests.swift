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
  var insertCallCount = 0

  func deleteCacheFeed() {
    deleteCacheFeedCallCount += 1
  }

  func completeDeletion(with error: Error, at index: Int = 0) {

  }
}

final class CacheFeedUseCaseTests: XCTestCase {

  func test_init_doesNotDeleteCacheUponCreation() {
    let (_, store) = makeSUT()

    XCTAssertEqual(store.deleteCacheFeedCallCount, 0)
  }

  func test_save_requestCacheDeletion() {
    let items = [uniqueItem(), uniqueItem()]
    let (sut, store) = makeSUT()

    sut.save(items)

    XCTAssertEqual(store.deleteCacheFeedCallCount, 1)
  }

  func test_save_doesNotRequestCacheInsertionOnDeletionError() {
    let items = [uniqueItem(), uniqueItem()]
    let (sut, store) = makeSUT()
    let deletionError = anyNSError()

    sut.save(items)
    store.completeDeletion(with: deletionError)

    XCTAssertEqual(store.insertCallCount, 0)
  }

}

extension CacheFeedUseCaseTests {

  private func makeSUT(file: StaticString = #filePath,
                       line: UInt = #line
  ) -> (sut: LocalFeedLoaer, store: FeedStore) {
    let store = FeedStore()
    let sut = LocalFeedLoaer(store: store)

    trackForMemoryLeaks(store, file: file, line: line)
    trackForMemoryLeaks(sut, file: file, line: line)

    return (sut, store)
  }

  private func uniqueItem() -> FeedItem {
    FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
  }

  private func anyURL() -> URL {
    URL(string: "http://any-url.com")!
  }

  private func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
  }
}
