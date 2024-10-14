//
//  FeedLoader.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 14/10/24.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
