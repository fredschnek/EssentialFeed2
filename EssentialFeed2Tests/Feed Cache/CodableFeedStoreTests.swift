//
//  CodableFeedStoreTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 26/11/24.
//

import XCTest
import EssentialFeed2

class CodabeFeedStore {
  func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
    completion(.empty)
  }
}

final class CodableFeedStoreTests: XCTestCase {

  func test_retrieve_deliversEmptyOnEmptyCache() {
    let sut = CodabeFeedStore()
    let exp = expectation(description: "Wait for cache retrieval")

    sut.retrieve { result in
      switch result {
      case .empty:
        break

      default:
        XCTFail("Expected empty result, got \(result) instead")
      }

      exp.fulfill()
    }

    wait(for: [exp], timeout: 1.0)
  }

}
