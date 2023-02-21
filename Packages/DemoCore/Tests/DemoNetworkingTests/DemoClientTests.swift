//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
@testable import DemoNetworking

final class MockNetworkSession: NetworkSession {

  var currentResponse: Result<(Data, URLResponse), Error>!

  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    switch currentResponse! {
    case .success(let data):
      return data
    case .failure(let error):
      throw error
    }
  }

}

final class DemoClientTests: XCTestCase {

  private var client: DemoClient!
  private var networkSession: MockNetworkSession!

  override func setUp() {
    networkSession = MockNetworkSession()
    client = DemoClient(session: networkSession)
  }

  func testInvalidRequest() async {
    let request = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: [""]))
    networkSession.currentResponse = .failure(DemoErrors.invalidRequest)

    let response = await client.performRequest(request: request)
    XCTAssertEqual(
      response.error?.localizedDescription,
      "Invalid request")
  }

  func testValidWithClientErrorRequest() async {
    let request = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: [""]))
    let httpsResponse = HTTPURLResponse(
      url: URL(string: "https://google.com")!,
      statusCode: 400,
      httpVersion: nil,
      headerFields: nil)
    networkSession.currentResponse = .success((Data(), httpsResponse!))

    let response = await client.performRequest(request: request)
    switch response {
    case .success: XCTFail("Should fail decoding here")
    case .failure(let failure):
      XCTAssertEqual(
        failure.localizedDescription,
        "Client error")
    }
  }

  func testValidWithServerErrorRequest() async {
    let request = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: [""]))
    let httpsResponse = HTTPURLResponse(
      url: URL(string: "https://google.com")!,
      statusCode: 500,
      httpVersion: nil,
      headerFields: nil)
    networkSession.currentResponse = .success((Data(), httpsResponse!))

    let response = await client.performRequest(request: request)
    switch response {
    case .success: XCTFail("Should fail decoding here")
    case .failure(let failure):
      XCTAssertEqual(
        failure.localizedDescription,
        "Server error")
    }
  }

  func testValidWithInvalidDecodablesRequest() async {
    let request = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: [""]))
    let httpsResponse = HTTPURLResponse(
      url: URL(string: "https://google.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil)
    networkSession.currentResponse = .success((Data(), httpsResponse!))

    let response = await client.performRequest(request: request)
    switch response {
    case .success: XCTFail("Should fail decoding here")
    case .failure(let failure):
      XCTAssertEqual(
        failure.localizedDescription,
        "The data couldn’t be read because it isn’t in the correct format.")
    }
  }

  func testValidWithValidDecodablesRequest() async {
    let request = MockRequest(
      request: RequestObject<PassingResponse>(
        backend: .pasteBin,
        path: [""]))
    let httpsResponse = HTTPURLResponse(
      url: URL(string: "https://google.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil)
    let data = try! JSONEncoder().encode(PassingResponse(isValid: true))
    networkSession.currentResponse = .success((data, httpsResponse!))

    let response = await client.performRequest(request: request)
    switch response {
    case .success(let data): XCTAssertTrue(data.isValid)
    case .failure: XCTFail("Should never fail decoding here")
    }
  }
}

private extension Result {
  var error: Error? {
    switch self {
    case .success:
      return nil
    case .failure(let failure):
      return failure
    }
  }
}
