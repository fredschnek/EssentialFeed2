//
//  FeedItemMapper.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 16/10/24.
//

import Foundation

final class FeedItemsMapper {
  private struct Root: Decodable {
    let items: [RemoteFeedItem]
  }

  private static var OK_200: Int { 200 }

  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
    guard response.statusCode == 200,
          let root = try? JSONDecoder().decode(Root.self, from: data) else {
      throw RemoteFeedLoader.Error.invalidData
    }

    return root.items
  }
}
