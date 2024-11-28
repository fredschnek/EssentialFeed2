//
//  ValidateFeedCacheUseCase.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 26/11/24.
//

import XCTest
import EssentialFeed2

final class ValidateFeedCacheUseCase: XCTestCase {
  func test_init_doesNotMessageStoreUponCreation() {
    let (_, store) = makeSUT()
    XCTAssertEqual(store.receivedMessages, [])
  }

  func test_validateCache_deletesCacheOnRetrievalError() {
    let (sut, store) = makeSUT()

    sut.validateCache()
    store.completeRetrieval(with: anyNSError())

    XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
  }

  func test_validateCache_doeNotDeleteCacheOnEmptyCache() {
    let (sut, store) = makeSUT()

    sut.validateCache()
    store.completeRetrievalWithEmptyCache()

    XCTAssertEqual(store.receivedMessages, [.retrieve])
  }

  func test_validateCache_doesNotDeleteCacheOnNonExpiredCache() {
    let feed = uniqueImageFeed()
    let fixedCurrentDate = Date()
    let nonExpiredTimestamp = fixedCurrentDate.minusFeedCacheMaxAge().adding(seconds: 1)
    let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })

    sut.validateCache()
    store.completeRetrieval(with: feed.local, timestamp: nonExpiredTimestamp)

    XCTAssertEqual(store.receivedMessages, [.retrieve])
  }

  func test_validateCache_deletesCacheOnExpiration() {
    let feed = uniqueImageFeed()
    let fixedCurrentDate = Date()
    let expirationTimestamp = fixedCurrentDate.minusFeedCacheMaxAge()
    let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })

    sut.validateCache()
    store.completeRetrieval(with: feed.local, timestamp: expirationTimestamp)

    XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
  }

  func test_validateCache_deletesExpiredCache() {
    let feed = uniqueImageFeed()
    let fixedCurrentDate = Date()
    let expiredTimestamp = fixedCurrentDate.minusFeedCacheMaxAge().adding(seconds: -1)
    let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })

    sut.validateCache()
    store.completeRetrieval(with: feed.local, timestamp: expiredTimestamp)

    XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
  }

  func test_validateCache_doesNotDeletesInvalidCachetAfterSUTInstanceHasBeenDeallocated() {
    let store = FeedStoreSpy()
    var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)

    sut?.validateCache()

    sut = nil
    store.completeRetrieval(with: anyNSError())

    XCTAssertEqual(store.receivedMessages, [.retrieve])
  }
}

extension ValidateFeedCacheUseCase {

  private func makeSUT(currentDate: @escaping () -> Date = Date.init,
                       file: StaticString = #filePath,
                       line: UInt = #line
  ) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
    let store = FeedStoreSpy()
    let sut = LocalFeedLoader(store: store, currentDate: currentDate)

    trackForMemoryLeaks(store, file: file, line: line)
    trackForMemoryLeaks(sut, file: file, line: line)

    return (sut, store)
  }

  private func expect(_ sut: LocalFeedLoader,
                      toCompleteWith expectedResult: LocalFeedLoader.LoadResult,
                      when action: () -> Void,
                      file: StaticString = #file,
                      line: UInt = #line
  ) {
    let exp = expectation(description: "Wait for load completion")

    sut.load { receivedResult in
      switch (receivedResult, expectedResult) {
      case let (.success(receivedImages), .success(expectedImages)):
        XCTAssertEqual(receivedImages, expectedImages, file: file, line: line)

      case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
        XCTAssertEqual(receivedError, expectedError, file: file, line: line)

      default:
        XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
      }

      exp.fulfill()
    }

    action()
    wait(for: [exp], timeout: 1.0)
  }
}
