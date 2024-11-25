//
//  LoadFeedFromCacheUseCaseTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 25/11/24.
//

import XCTest
import EssentialFeed2

class LoadFeedFromCacheUseCaseTests: XCTestCase {

  func test_init_doesNotMessageStoreUponCreation() {
    let (_, store) = makeSUT()
    XCTAssertEqual(store.receivedMessages, [])
  }
  
}

extension LoadFeedFromCacheUseCaseTests {

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

  private class FeedStoreSpy: FeedStore {

    enum ReceivedMessage: Equatable {
      case deleteCacheFeed
      case insert([LocalFeedImage], Date)
    }

    private(set) var receivedMessages = [ReceivedMessage]()

    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()

    func deleteCacheFeed(completion: @escaping DeletionCompletion) {
      deletionCompletions.append(completion)
      receivedMessages.append(.deleteCacheFeed)
    }

    func completeDeletion(with error: Error, at index: Int = 0) {
      deletionCompletions[index](error)
    }

    func completeDeletionSuccessfully(at index: Int = 0) {
      deletionCompletions[index](nil)
    }

    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
      insertionCompletions.append(completion)
      receivedMessages.append(.insert(feed, timestamp))
    }

    func completeInsertion(with error: Error, at index: Int = 0) {
      insertionCompletions[index](error)
    }

    func completeInsertionSuccessfully(at index: Int = 0) {
      insertionCompletions[index](nil)
    }
  }

}
