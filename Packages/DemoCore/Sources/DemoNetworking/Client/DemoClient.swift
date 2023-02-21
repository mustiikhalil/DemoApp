//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

public final class DemoClient {

  private let session: NetworkSession

  public init(session: NetworkSession) {
    self.session = session
  }

  public func performRequest<R>(request: R)
  async -> Result<R.Response, Error> where R: Request, R.Response: Decodable
  {
    guard let urlRequest = request.urlRequest else {
      return .failure(DemoErrors.invalidRequest)
    }
    do {
      let (data, response) = try await session.data(for: urlRequest)
      // There are alot of ways to check the response,
      // however this was the easiest for a demo project
      switch response.checkedResponse {
      case .valid:
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = request.keyDecodingStrategy
        decoder.dateDecodingStrategy = request.dateDecodingStrategy
        // we assume that the server will always return data properly
        let data = try decoder.decode(R.Response.self, from: data)
        return .success(data)
      case .serverError, .unknown:
        return .failure(DemoErrors.serverError)
      case .clientError:
        return .failure(DemoErrors.clientError)
      }
    } catch {
      return .failure(error)
    }
  }

}
