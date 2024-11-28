//
//  EssentialFeedCacheIntegrationTests.swift
//  EssentialFeedCacheIntegrationTests
//
//  Created by Frederico Schnekenberg on 28/11/24.
//

import XCTest
import EssentialFeed2

final class EssentialFeedCacheIntegrationTests: XCTestCase {

  func test_load_deliversNoItemsOnEmptyCache() throws {
    let sut = try makeSUT()

    let exp = expectation(description: "Wait for load completion")
    sut.load { result in
      switch result {
      case let .success(imageFeed):
        XCTAssertEqual(imageFeed, [], "Expected empty feed")

      case let .failure(error):
        XCTFail("Expected successful feed result, got \(error) instead")

      @unknown default:
        XCTFail("Expected successful feed result, got no result instead")
      }

      exp.fulfill()
    }
    wait(for: [exp], timeout: 1.0)
  }
}

// MARK: - Helpers

extension EssentialFeedCacheIntegrationTests {
  private func makeSUT(file: StaticString = #file, line: UInt = #line) throws -> LocalFeedLoader {
    let storeBundle = Bundle(for: CoreDataFeedStore.self)
    let storeURL = testSpecificStoreURL()
    let store = try CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
    let sut = LocalFeedLoader(store: store, currentDate: Date.init)
    trackForMemoryLeaks(store, file: file, line: line)
    trackForMemoryLeaks(sut, file: file, line: line)
    return sut
  }
  
  private func testSpecificStoreURL() -> URL {
    return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
  }
  
  private func cachesDirectory() -> URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
  }
}

