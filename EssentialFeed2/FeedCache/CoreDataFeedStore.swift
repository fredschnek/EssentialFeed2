//
//  CoreDataFeedStore.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 27/11/24.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
  public init() {}

  public func retrieve(completion: @escaping RetrievalCompletion) {
    completion(.empty)
  }
  
  public func deleteCacheFeed(completion: @escaping DeletionCompletion) {

  }
  
  public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {

  }
}
