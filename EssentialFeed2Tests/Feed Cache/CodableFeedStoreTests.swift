//
//  CodableFeedStoreTests.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 26/11/24.
//

import XCTest
import EssentialFeed2

final class CodableFeedStoreTests: XCTestCase, FailableFeedStoreSpecs {
  override func setUp() {
    super.setUp()
    setupEmptyStoreState()
  }

  override func tearDown() {
    undoStoreSideEffects()
    super.tearDown()
  }
}

// MARK: - Retrieve tests

extension CodableFeedStoreTests {
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

  func test_retrieve_deliversFailureOnRetrievalError() {
    let storeURL = testSpecificStoreURL()
    let sut = makeSUT(storeURL: storeURL)

    try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)

    assertThatRetrieveDeliversFailureOnRetrievalError(on: sut)
  }

  func test_retrieve_hasNoSideEffectsOnFailure() {
    let storeURL = testSpecificStoreURL()
    let sut = makeSUT(storeURL: storeURL)

    try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)

    assertThatRetrieveHasNoSideEffectsOnFailure(on: sut)
  }
}

// MARK: - Insertion tests

extension CodableFeedStoreTests {
  func test_insert_deliversNoErrorOnEmptyCache() {
    let sut = makeSUT()

    assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_insert_deliversNoErrorOnNonEmptyCache() {
    let sut = makeSUT()

    assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
  }

  func test_insert_overridesPreviouslyInsertedCacheValues() {
    let sut = makeSUT()

    assertThatInsertOverridesPreviouslyInsertedCacheValues(on: sut)
  }

  func test_insert_deliversErrorOnInsertionError() {
    let invalidStoreURL = URL(string: "invalid://store-url")!
    let sut = makeSUT(storeURL: invalidStoreURL)

    assertThatInsertDeliversErrorOnInsertionError(on: sut)
  }

  func test_insert_hasNoSideEffectsOnInsertionError() {
    let invalidStoreURL = URL(string: "invalid://store-url")!
    let sut = makeSUT(storeURL: invalidStoreURL)

    assertThatInsertHasNoSideEffectsOnInsertionError(on: sut)
  }
}

// MARK: - Deletion tests

extension CodableFeedStoreTests {
  func test_delete_deliversNoErrorOnEmptyCache() {
    let sut = makeSUT()

    assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
  }

  func test_delete_hasNoSideEffectsOnEmptyCache() {
    let sut = makeSUT()

    assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
  }

  func test_delete_deliversNoErrorOnNonEmptyCache() {
    let sut = makeSUT()

    assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
  }

  func test_delete_emptiesPreviouslyInsertedCache() {
    let sut = makeSUT()

    assertThatDeleteEmptiesPreviouslyInsertedCache(on: sut)
  }

  func test_delete_deliversErrorOnDeletionError() {
    let noDeletePermissionURL = cachesDirectory()
    let sut = makeSUT(storeURL: noDeletePermissionURL)

    assertThatDeleteDeliversErrorOnDeletionError(on: sut)
  }

  func test_delete_hasNoSideEffectsOnDeletionError() {
    let noDeletePermissionURL = cachesDirectory()
    let sut = makeSUT(storeURL: noDeletePermissionURL)

    assertThatDeleteHasNoSideEffectsOnDeletionError(on: sut)
  }
}

// MARK: - Thread-Safe Behavior tests

extension CodableFeedStoreTests {

  func test_storeSideEffects_runSerially() {
    let sut = makeSUT()
    var completedOperationsInOrder = [XCTestExpectation]()

    let op1 = expectation(description: "Operation 1")
    sut.insert(uniqueImageFeed().local, timestamp: Date()) { _ in
      completedOperationsInOrder.append(op1)
      op1.fulfill()
    }

    let op2 = expectation(description: "Operation 2")
    sut.deleteCacheFeed { _ in
      completedOperationsInOrder.append(op2)
      op2.fulfill()
    }

    let op3 = expectation(description: "Operation 3")
    sut.insert(uniqueImageFeed().local, timestamp: Date()) { _ in
      completedOperationsInOrder.append(op3)
      op3.fulfill()
    }

    waitForExpectations(timeout: 5.0)

    XCTAssertEqual(completedOperationsInOrder, [op1, op2, op3], "Expected side-effects to run serially but operations finished in the wrong order")
  }

}

// MARK: - Helpers

extension CodableFeedStoreTests {
  private func makeSUT(storeURL: URL? = nil, file: StaticString = #file, line: UInt = #line) -> FeedStore {
    let sut = CodableFeedStore(storeURL: storeURL ?? testSpecificStoreURL())
    trackForMemoryLeaks(sut, file: file, line: line)
    return sut
  }

  private func setupEmptyStoreState() {
    deleteStoreArtifacts()
  }

  private func undoStoreSideEffects() {
    deleteStoreArtifacts()
  }

  private func deleteStoreArtifacts() {
    try? FileManager.default.removeItem(at: testSpecificStoreURL())
  }

  private func testSpecificStoreURL() -> URL {
    return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
  }

  private func cachesDirectory() -> URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
  }
}
