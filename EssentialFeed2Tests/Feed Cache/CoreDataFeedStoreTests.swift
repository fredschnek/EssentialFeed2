//
//  CoreDataFeedStoreTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 27/11/24.
//

import XCTest
import EssentialFeed2

// MARK: - Retrieval tests

class CoreDataFeedStoreTests: XCTestCase, FeedStoreSpecs {
  func test_retrieve_deliversEmptyOnEmptyCache() {
    let sut = makeSUT()
    assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
  }

  func test_retrieve_hasNoSideEffectsOnEmptyCache() {
    let sut = makeSUT()
    assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
  }

  func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
    let sut = makeSUT()
    assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
  }

  func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
    let sut = makeSUT()
    assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
  }
}

// MARK: - Insertion tests

extension CoreDataFeedStoreTests {
  func test_insert_deliversNoErrorOnEmptyCache() {
    let sut = makeSUT()
    assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_insert_deliversNoErrorOnNonEmptyCache() {
    let sut = makeSUT()
    assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_insert_overridesPreviouslyInsertedCacheValues() {

  }
}

extension CoreDataFeedStoreTests {
  func test_delete_deliversNoErrorOnEmptyCache() {

  }
  
  func test_delete_hasNoSideEffectsOnEmptyCache() {

  }
  
  func test_delete_deliversNoErrorOnNonEmptyCache() {

  }
  
  func test_delete_emptiesPreviouslyInsertedCache() {
  
  }
  
  func test_storeSideEffects_runSerially() {

  }
}

// MARK: - Helpers

extension CoreDataFeedStoreTests {
  private func makeSUT(file: StaticString = #file, line: UInt = #line) -> FeedStore {
    let storeBundle = Bundle(for: CoreDataFeedStore.self)
    let storeURL = URL(fileURLWithPath: "/dev/null")
    let sut = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
    trackForMemoryLeaks(sut, file: file, line: line)
    return sut
  }
}
