//
//  SharedtestHelpers.swift
//  EssentialFeed2Tests
//
//  Created by Frederico Schnekenberg on 26/11/24.
//

import Foundation

func anyURL() -> URL {
  URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
  NSError(domain: "any error", code: 0)
}
