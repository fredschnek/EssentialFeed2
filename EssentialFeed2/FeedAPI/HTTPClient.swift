//
//  HTTPClient.swift
//  EssentialFeed2
//
//  Created by Frederico Schnekenberg on 16/10/24.
//

import Foundation

/// A protocol that defines an HTTP client for making network requests.
public protocol HTTPClient {

  /// A typealias representing the result of an HTTP client request.
  /// - Success: Contains the response `Data` and the associated `HTTPURLResponse`.
  /// - Failure: Contains an `Error` indicating what went wrong.
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

  /// Performs an HTTP GET request to the specified URL.
  ///
  /// - Parameters:
  ///   - url: The `URL` to which the GET request is made.
  ///   - completion: A closure that is called when the request completes.
  ///     - The closure provides a `HTTPClientResult`:
  ///       - `.success`: Includes the `Data` from the response and the `HTTPURLResponse`.
  ///       - `.failure`: Includes an `Error` describing the issue.
  ///
  /// - Important: The `completion` handler can be invoked on any thread.
  ///   The caller is responsible for dispatching to the appropriate thread if needed.
  func get(from url: URL, completion: @escaping (Result) -> Void)
}
