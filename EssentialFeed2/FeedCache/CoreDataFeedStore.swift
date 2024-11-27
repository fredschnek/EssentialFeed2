//
//  CoreDataFeedStore.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 27/11/24.
//

import CoreData
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

private class ManagedCache: NSManagedObject {
  @NSManaged var timestamp: Date
  @NSManaged var feed: NSOrderedSet
}

private class ManagedFeedImage: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var imageDescription: String?
  @NSManaged var location: String?
  @NSManaged var url: URL
  @NSManaged var cache: ManagedCache
}
