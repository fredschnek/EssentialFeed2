//
//  FeedCacheTestHelpers.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 26/11/24.
//

import Foundation
import EssentialFeed2

func uniqueImage() -> FeedImage {
  FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
  let items = [uniqueImage(), uniqueImage()]
  let localItems = items.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
  return (items, localItems)
}

extension Date {
  func adding(days: Int) -> Date {
    Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
  }

  func adding(seconds: TimeInterval) -> Date {
    self + seconds
  }
}
