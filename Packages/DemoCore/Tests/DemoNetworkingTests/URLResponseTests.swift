//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
@testable import DemoNetworking

final class MockResponse: URLResponse {}

final class URLResponseTests: XCTestCase {

  private var url: URL!

  override func setUp() {
    url = URL(string: "https://google.com")!
  }

  func testValidResponse() {
    let response = HTTPURLResponse(
      url: url,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response?.checkedResponse, .valid)

    let response2 = HTTPURLResponse(
      url: url,
      statusCode: 299,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response2?.checkedResponse, .valid)
  }

  func testClientErrorResponse() {
    let response = HTTPURLResponse(
      url: url,
      statusCode: 400,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response?.checkedResponse, .clientError)

    let response2 = HTTPURLResponse(
      url: url,
      statusCode: 499,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response2?.checkedResponse, .clientError)
  }

  func testServerErrorResponse() {
    let response = HTTPURLResponse(
      url: url,
      statusCode: 500,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response?.checkedResponse, .serverError)

    let response2 = HTTPURLResponse(
      url: url,
      statusCode: 599,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response2?.checkedResponse, .serverError)
  }

  func testUnknownResponse() {
    let mockResponse = MockResponse(
      url: url,
      mimeType: "",
      expectedContentLength: 0,
      textEncodingName: "")
    XCTAssertEqual(mockResponse.checkedResponse, .unknown)

    let response = HTTPURLResponse(
      url: url,
      statusCode: 700,
      httpVersion: nil,
      headerFields: nil)
    XCTAssertEqual(response?.checkedResponse, .unknown)
  }

}
