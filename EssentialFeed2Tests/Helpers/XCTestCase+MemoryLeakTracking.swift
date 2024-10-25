//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 21/10/24.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
