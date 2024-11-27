//
//  FeedStore.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 25/11/24.
//

import Foundation

public enum RetrieveCachedFeedResult {
  case empty
  case found(feed: [LocalFeedImage], timestamp: Date)
  case failure(Error)
}

public protocol FeedStore {
  typealias DeletionCompletion = (Error?) -> Void
  typealias InsertionCompletion = (Error?) -> Void
  typealias RetrievalCompletion = (RetrieveCachedFeedResult) -> Void

  func retrieve(completion: @escaping RetrievalCompletion)
  func deleteCacheFeed(completion: @escaping DeletionCompletion)
  func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
}
