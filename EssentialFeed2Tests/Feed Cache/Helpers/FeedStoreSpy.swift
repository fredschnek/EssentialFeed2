//
//  FeedStoreSpy.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 25/11/24.
//

import Foundation
import EssentialFeed2

class FeedStoreSpy: FeedStore {

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
