//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 27/11/24.
//

import XCTest
import EssentialFeed2

extension FailableDeleteFeedStoreSpecs where Self: XCTestCase {
  func assertThatDeleteDeliversErrorOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
    let deletionError = deleteCache(from: sut)

    XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
  }

  func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
    deleteCache(from: sut)

    expect(sut, toRetrieve: .success(.none), file: file, line: line)
  }
}
