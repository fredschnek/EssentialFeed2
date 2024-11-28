//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 14/10/24.
//

import Foundation

public protocol FeedLoader {
  typealias Result = Swift.Result<[FeedImage], Error>
  func load(completion: @escaping (Result) -> Void)
}
