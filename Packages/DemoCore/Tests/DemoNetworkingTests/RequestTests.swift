//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
@testable import DemoNetworking

final class RequestTests: XCTestCase {

  func testCreatingValidURL() {
    let mockRequest = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: ["id"]))
    XCTAssertEqual(
      mockRequest.urlRequest?.url?.absoluteString,
      "https://pastebin.com/raw/id")
  }

  func testCreatingValidQueryURL() {
    let mockRequest = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: ["id"],
        query: [
          "page": "\(1)",
          "per_page": "\(10)"
        ]))
    let request = mockRequest.urlRequest
    XCTAssertTrue(
      request?.url?.absoluteString.contains("page=1") ?? false)
    XCTAssertTrue(
      request?.url?.absoluteString.contains("per_page=10") ?? false)
  }

}

struct MockRequest<T>: Request where T: Decodable {
  typealias Response = T
  var request: RequestObject<Response>
}

struct PassingResponse: Codable {
  let isValid: Bool
}
