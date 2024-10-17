//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 14/10/24.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
