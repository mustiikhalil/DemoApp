//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

enum CheckedResponse {
  case valid, clientError, serverError, unknown
}

extension URLResponse {

  var checkedResponse: CheckedResponse {

    guard let response = self as? HTTPURLResponse else { return .unknown }

    switch response.statusCode {
    case 200..<300:
      return .valid
    case 400..<500:
      return .clientError
    case 500..<600:
      return .serverError
    default:
      return .unknown
    }
  }
}
