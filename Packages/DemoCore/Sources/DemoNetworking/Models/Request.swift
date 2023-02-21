//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

public enum BackendURL: String {
  case pasteBin = "https://pastebin.com/raw/"
}

public struct RequestObject<T: Decodable> {
  public init(backend: BackendURL, path: [String], query: [String : String]? = nil) {
    self.backend = backend
    self.path = path
    self.query = query
  }

  let backend: BackendURL
  let path: [String]
  let query: [String: String]?
}

public protocol Response {}

public protocol Request {
  associatedtype Response where Response: Decodable

  var request: RequestObject<Response> { get }
  var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
  var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

extension Request {
  public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { .useDefaultKeys }
  public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { .iso8601 }
}

extension Request {

  var urlRequest: URLRequest? {
    let path = request.backend.rawValue + request.path.joined(separator: "/")
    guard let url = URL(string: path) else { return nil }
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

    if let query = request.query {
      var queryItems: [URLQueryItem] = []
      query.forEach { (key: String, value: String) in
        queryItems.append(URLQueryItem(name: key, value: value))
      }
      components?.queryItems = queryItems
    }
    guard let url = components?.url else { return nil }
    return URLRequest(url: url)
  }
}
