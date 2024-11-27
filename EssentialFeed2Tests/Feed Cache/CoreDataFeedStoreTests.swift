//
//  CoreDataFeedStoreTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 27/11/24.
//

import XCTest
import EssentialFeed2

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

  }
  
  func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {

  }
  
  func test_insert_deliversNoErrorOnEmptyCache() {

  }
  
  func test_insert_deliversNoErrorOnNonEmptyCache() {

  }
  
  func test_insert_overridesPreviouslyInsertedCacheValues() {

  }
  
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
    let sut = CoreDataFeedStore()
    trackForMemoryLeaks(sut, file: file, line: line)
    return sut
  }
}