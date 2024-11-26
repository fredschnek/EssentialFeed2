//
//  FeedCachePolicy.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 26/11/24.
//

import Foundation

internal final class FeedCachePolicy {
  private init() {}

  private static var maxCacheAgeInDays: Int { 7 }
  private static let calendar = Calendar(identifier: .gregorian)

  internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
    guard let maxAgeCache = calendar.date(
      byAdding: .day,
      value: maxCacheAgeInDays,
      to: timestamp
    ) else { return false }
    return date < maxAgeCache
  }
}
