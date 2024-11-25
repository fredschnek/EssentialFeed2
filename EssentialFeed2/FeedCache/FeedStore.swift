//
//  FeedStore.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 25/11/24.
//

import Foundation

public protocol FeedStore {
  typealias DeletionCompletion = (Error?) -> Void
  typealias InsertionCompletion = (Error?) -> Void
  func deleteCacheFeed(completion: @escaping DeletionCompletion)
  func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}
