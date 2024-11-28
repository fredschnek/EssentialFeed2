//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 14/10/24.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
