//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

public enum DemoErrors: Error {
  // we can pass in errors into these values
  // serverError(error: Error)
  case serverError, clientError, invalidRequest
}

extension DemoErrors: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .clientError:
      return "Client error"
    case .serverError:
      return "Server error"
    case .invalidRequest:
      return "Invalid request"
    }
  }
}
