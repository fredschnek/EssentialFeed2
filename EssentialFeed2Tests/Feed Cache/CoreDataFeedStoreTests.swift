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
  func test_retrieve_deliversEmptyOnEmptyCache() throws {
    let sut = try makeSUT()
    assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
  }

  func test_retrieve_hasNoSideEffectsOnEmptyCache() throws {
    let sut = try makeSUT()
    assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
  }

  func test_retrieve_deliversFoundValuesOnNonEmptyCache() throws {
    let sut = try makeSUT()
    assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
  }

  func test_retrieve_hasNoSideEffectsOnNonEmptyCache() throws {
    let sut = try makeSUT()
    assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
  }
}

// MARK: - Insertion tests

extension CoreDataFeedStoreTests {
  func test_insert_deliversNoErrorOnEmptyCache() throws {
    let sut = try makeSUT()
    assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_insert_deliversNoErrorOnNonEmptyCache() throws {
    let sut = try makeSUT()
    assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_insert_overridesPreviouslyInsertedCacheValues() throws {
    let sut = try makeSUT()
    assertThatInsertOverridesPreviouslyInsertedCacheValues(on: sut)
  }
}

// MARK: - Deletion tests

extension CoreDataFeedStoreTests {
  func test_delete_deliversNoErrorOnEmptyCache() throws {
    let sut = try makeSUT()
    assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_delete_hasNoSideEffectsOnEmptyCache() throws {
    let sut = try makeSUT()
    assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
  }

  func test_delete_deliversNoErrorOnNonEmptyCache() throws {
    let sut = try makeSUT()
    assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
  }

  func test_delete_emptiesPreviouslyInsertedCache() throws {
    let sut = try makeSUT()
    assertThatDeleteEmptiesPreviouslyInsertedCache(on: sut)
  }
}

// MARK: - Store side-effects

extension CoreDataFeedStoreTests {
  func test_storeSideEffects_runSerially() throws {
    let sut = try makeSUT()
    assertThatSideEffectsRunSerially(on: sut)
  }
}

// MARK: - Helpers

extension CoreDataFeedStoreTests {
  private func makeSUT(file: StaticString = #file, line: UInt = #line) throws -> FeedStore {
    let storeBundle = Bundle(for: CoreDataFeedStore.self)
    let storeURL = URL(fileURLWithPath: "/dev/null")
    let sut = try CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
    trackForMemoryLeaks(sut, file: file, line: line)
    return sut
  }
}
